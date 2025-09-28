# PRD: f-pwd - File Path Display with Clipboard Copy

## Overview
The `f-pwd` feature provides an interactive FZF-based file selector that displays both absolute and relative paths of selected files and automatically copies the absolute path to the clipboard.

## Problem Statement
Currently, when working with files in the terminal, users need to manually construct or copy file paths. This can be tedious when needing to reference files in different contexts (scripts, documentation, or other tools).

## Solution
Create a new make target `f-pwd` that:
1. Uses FZF for interactive file selection with preview
2. Outputs both absolute and relative paths to the terminal
3. Automatically copies the absolute path to clipboard (via pbcopy on macOS)

## Technical Implementation

### Location
- Target will be added to `/fzf/crud.mk` as a read method

### Dependencies
- FZF for file selection interface
- Existing crud.sh helper functions
- ui.sh for consistent UI messaging
- pbcopy for clipboard operations (macOS)

### User Flow
1. User runs `make f-pwd`
2. FZF interface opens with file preview
3. User navigates and selects a file
4. Terminal displays:
   - Relative path: `./path/to/file`
   - Absolute path: `/full/path/to/file`
5. Absolute path is copied to clipboard automatically
6. User receives confirmation message

### Features
- Interactive file browser with arrow key navigation
- File preview in FZF interface (using bat if available, else cat)
- Exclude common directories (.git, node_modules, etc.)
- Clean output format showing both path types
- Automatic clipboard integration
- Graceful exit on ESC or cancellation

## Success Criteria
- [ ] File selection works with FZF interface
- [ ] Both absolute and relative paths are displayed
- [ ] Absolute path is copied to clipboard
- [ ] Respects file exclusion patterns
- [ ] Provides clear user feedback
- [ ] Integrates seamlessly with existing FZF crud targets

## Example Output
```bash
$ make f-pwd
# FZF interface opens...
# User selects: src/utils/helpers.js

Relative path: ./src/utils/helpers.js
Absolute path: /Users/username/project/src/utils/helpers.js
✓ Absolute path copied to clipboard
```