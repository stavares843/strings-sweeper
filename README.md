<p align="center">
<img width="608" alt="Captura de ecrã 2023-12-06, às 01 18 19" src="https://github.com/stavares843/strings-sweeper/assets/29093946/f66656ed-49e8-499d-add0-ee967c98d864">
</p>

<p align="center">A Swift script to determine and optionally remove unused localization keys in your project.</h1>


## Description

- Determines unused localization keys by scanning Swift files in the project.
- Optionally removes unused keys from the specified language file.
- Creates a backup of the original language file before removal.

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


https://github.com/stavares843/strings-sweeper/assets/29093946/8a23b46c-08ac-4b5f-8087-2eb02f49f044


## Options

`--lang`: Specify the path to the language file (default is ./Localizable.strings).

`--remove`: Automatically remove unused keys from the language file.
