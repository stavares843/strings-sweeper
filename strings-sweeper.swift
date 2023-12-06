import Foundation

// Determines unused lang keys and optionally removes them
// Run this Swift script by executing it from the command line
// It will print out all unused lang keys
// You can also automatically remove unused lang keys

let args = CommandLine.arguments
var langFile = "./Localizable.strings"
var shouldRemoveKeys = false

if args.contains("--lang") {
    if let index = args.firstIndex(of: "--lang"), index + 1 < args.count {
        langFile = args[index + 1]
    }
}

if args.contains("--remove") {
    shouldRemoveKeys = true
}

// Backup language file with a timestamp
func backupLanguageFile() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMddHHmmss"
    let timestamp = dateFormatter.string(from: Date())
    let backupFile = langFile + ".bak" + timestamp
    do {
        try FileManager.default.copyItem(atPath: langFile, toPath: backupFile)
        print("Backup created: \(backupFile)")
    } catch {
        print("Error: Failed to create a backup of the language file.")
        exit(1)
    }
}

// Read the en lang file
guard let langContent = try? String(contentsOfFile: langFile) else {
    print("Error: Unable to read the language file at \(langFile)")
    exit(1)
}

var keys = Set<String>()
var lines = [(String, String)]()
var rootKey = ""

langContent.enumerateLines { line, _ in
    let stripped = line.trimmingCharacters(in: .whitespaces)

    if stripped.isEmpty {
        lines.append(("", line))
        return
    }

    var langKey = ""

    if stripped.hasPrefix(".") {
        let split = stripped.components(separatedBy: " = ")
        langKey = rootKey + split[0]
        keys.insert(langKey)
    } else {
        rootKey = stripped.components(separatedBy: " = ")[0]
        langKey = rootKey
        keys.insert(rootKey)
    }

    lines.append((langKey, line))
}

// Collect all Swift files
if let files = try? FileManager.default.subpathsOfDirectory(atPath: FileManager.default.currentDirectoryPath) {
    // Remove build files
    let filteredFiles = files.filter { !$0.hasPrefix("target/") && $0.hasSuffix(".swift") }

    // Remove dynamically created keys, e.g., toast action keys
    keys = keys.filter { !$0.hasPrefix("toast_actions") }

    // Check Swift files if the language key is used
    for file in filteredFiles {
        if let content = try? String(contentsOfFile: file) {
            keys = keys.filter { !content.contains($0) }
        }
    }

    // Print unused keys
    let unusedKeys = keys.joined(separator: "\n")
    print(unusedKeys.isEmpty ? "No unused keys found." : "Unused keys:\n\(unusedKeys)")

    if shouldRemoveKeys {
        // Filter out the lines with unused keys
        let modifiedLines = lines.filter { !keys.contains($0.0) }.map { $0.1 }
        
        // Join the modified lines into a single string
        let modifiedContent = modifiedLines.joined(separator: "\n")
        
        // Backup the original language file
        backupLanguageFile()
        
        // Write the modified content back to the language file
        do {
            try modifiedContent.write(toFile: langFile, atomically: false, encoding: .utf8)
            print("Unused keys removed from \(langFile).")
        } catch {
            print("Error: Failed to write modified content back to the language file.")
            exit(1)
        }
    }
}
