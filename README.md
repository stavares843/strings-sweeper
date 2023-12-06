

<p align="center">
  <img src="https://github.com/stavares843/strings-sweeper/assets/29093946/53adad7a-1f60-4738-a60a-d21c76b58b3e"/>
</p>

<p align="center">A Swift script to determine and optionally remove unused localization keys in your project.</h1>

## Usage

### Prerequisites

- Swift installed on your machine.

### Running the Script

1. Open Terminal.
2. Copy paste the script in your project
3. Navigate to your project

Replace `/path/to/your/Localizable.strings` with the actual path to your Localizable.strings file.

The `--remove` flag is optional and will automatically remove unused keys from the file.

`swift strings-sweeper.swift --lang /path/to/your/Localizable.strings --remove`

`swift strings-sweeper.swift --lang ./Localizable.strings --remove`

## Script Details
- Determines unused localization keys by scanning Swift files in the project.
- Optionally removes unused keys from the specified language file.
- Creates a backup of the original language file before removal.


https://github.com/stavares843/strings-sweeper/assets/29093946/946b5db0-673f-4713-8142-45ddcd7f4684




## Options

`--lang`: Specify the path to the language file (default is ./Localizable.strings).

`--remove`: Automatically remove unused keys from the language file.
