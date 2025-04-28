# Document Conversion Tool for SpokenWeb Pedagogy of Sound Studies Project

This script converts a batch of documents to Markdown using Pandoc, and generates associated YAML metadata files based on a spreadsheet of metadata. It is designed so that the documents can be seamlessly added to a jekyll based web instance.

---

## Features

- Converts `.docx`, `.odt`, or similar documents to `.md` (markdown) using Pandoc
- Avoids underline artifacts by changing all underlined text to italicized
- Extracts metadata from spreadsheet (`metadata.xlsx` by default) and embeds it into each markdown file as a YAML block, including front matter for jekyll
- Additionally outputs separate `.yaml` files containing metadata for each document for easy metadata access
- Can be fed path to source or output directories or metadata spreadsheet as command line arguments, or run without args assuming the directory is set up as in this repo

---

## Directory Structure

Before running the script, the project directory should be organized as follows:

```
project/
├── SWConvertToMD
├── underline-to-italic.lua  # Lua filter for Pandoc to avoid underline artifacts
├── metadata.xlsx  # Spreadsheet containing document metadata
├── source/  # Folder containing the original documents to be converted to markdown
├── output_documents/  # Will be created if it doesn't exist (Markdown files)
└── output_yamls/  # Will be created if it doesn't exist (YAML metadata files)
```

> **Note:** The `output_documents` and `output_yamls` folders will be created automatically if they don't already exist.

> **Note:** Ensure that `underline-to-italic.lua` is present in the same directory as the script. If you don't have it, the Pandoc conversion might fail.

> **Notes:** If a document listed in the spreadsheet does not exist in the `source/` folder, the script will skip it and print a warning.

---

## Requirements

- Python 3.7+
- Pandoc installed and accessible from your system path.
- Required Python libraries:
  - `pandas`
  - `pyyaml`
  - `openpyxl` (to read `.xlsx` files)

Install the Python dependencies with:

```bash
pip install pandas pyyaml openpyxl
```

Install Pandoc via [Pandoc's installation instructions](https://pandoc.org/installing.html).


## Requirements for Metadata Spreadsheet Format (`metadata.xlsx` by default)

The spreadsheet should have the following columns:

| Column Name          | Description |
| --------------------- | ----------- |
| Last Name             | Author's last name |
| First Name            | Author's first name |
| Email                 | Author's email address |
| Institution           | Affiliated institution |
| Title of Doc          | Document title |
| File Name             | Filename of the document (!! must match exactly with the file in `source/`) |
| Original Doc Type     | Type of the original document (e.g., DOCX, ODT) |
| Primary Discpline     | Primary academic or professional discipline |
| URL                   | URL for reference (optional) |
| Comments              | Additional notes (optional) |

> **Note:** If the file name in the sheet does not exactly match with the file name in /source/, the script can't match files with metadata, and the YAML will not be added to the md

---

## How to Run

Using the command line, type:

```bash
python SWConvertToMD.py
```

By default, the script assumes:

- Source documents are in the `source/` folder
- Output Markdown files will go into `output_documents/`
- Output YAML files will go into `output_yamls/`
- Metadata spreadsheet is `metadata.xlsx` in the same directory

### Custom paths (optional)

You can override the default paths by using command-line arguments:

```bash
python SWConvertToMD.py \
  --source /path/to/source \
  --output-docs /path/to/output_documents \
  --output-yamls /path/to/output_yamls \
  --spreadsheet /path/to/metadata.xlsx
```

Example:

```bash
python SWConvertToMD.py --source ./my_docs --spreadsheet ./my_metadata.xlsx
```