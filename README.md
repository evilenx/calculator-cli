# Calculator-CLI

A powerful command-line calculator with VI-style navigation and advanced arithmetic capabilities.

## Features

* **VI-Style Navigation**: Familiar vim-like commands for a better terminal experience
* **Advanced Expression Parsing**: Handle complex mathematical expressions in a single line
* **Command History**: Easily access and reuse previous calculations
* **Operator Precedence**: Correctly handles mathematical order of operations
* **Error Handling**: Clear error messages for invalid expressions and division by zero

## Requirements

* Operating System: Unix-like OS (tested on macOS and Linux)
* Crystal Version: 1.0 or higher

## Installation

1. Clone the Repository:
```bash
git clone https://github.com/evilenx/calculator-cli
```

2. Navigate to the Repository:
```bash
cd calculator-cli
```

3. Build the Program:
```bash
crystal build src/calculator-cli.cr
```

## Usage

Run the calculator:
```bash
./calculator-cli
```

### Navigation Commands

The calculator starts in insert mode and supports the following VI-style commands:

* `ESC` - Enter normal mode
* `i` - Enter insert mode
* `k` - Previous command (in normal mode)
* `j` - Next command (in normal mode)
* `:q` - Quit calculator

### Expression Syntax

* Supports basic arithmetic operations: `+`, `-`, `*`, `/`, `^` (power)
* Handles floating-point numbers
* Respects operator precedence
* Allows spaces between numbers and operators

### Examples

```
> 2 + 2
2 + 2 = 4.0

> 3 * 4 + 5
3 * 4 + 5 = 17.0

> 10 / 2 + 3 * 4
10 / 2 + 3 * 4 = 17.0

> 2 ^ 3 + 1
2 ^ 3 + 1 = 9.0
```

### Using History

1. Type a calculation and press Enter
2. Press ESC to enter normal mode
3. Use `k` to scroll back through previous calculations
4. Use `j` to scroll forward
5. Press `i` to modify the selected calculation
6. Press Enter to execute

## Features in Detail

### Expression Parsing
- Handles both simple and complex expressions
- Supports operator precedence following mathematical rules
- Properly manages spaces between numbers and operators
- Validates input for correct mathematical syntax

### VI Navigation
- Familiar to vim users
- Efficient command history access
- Quick editing capabilities
- Mode-based operation (insert/normal)

### Error Handling
- Clear error messages for:
  - Invalid expressions
    - Division by zero
      - Malformed numbers
        - Unknown operators

        ## Contributing

        Contributions are welcome! Feel free to:
        - Report bugs
        - Suggest new features
        - Submit pull requests
        - Improve documentation

        ## License

        This project is licensed under the MIT License - see the LICENSE file for details.

        ## Changelog

        ### v0.2.0
        - Added VI-style navigation
        - Improved expression parsing
        - Added operator precedence
        - Enhanced error handling
        - Added command history

        ### v0.1.0
        - Initial release
        - Basic arithmetic operations
        - Simple command-line interface
