# Calculator-cli

## A Simple Command Line Calculator

Perform basic arithmetic operations directly from your terminal with this easy-to-use CLI tool.

### Features

- **User-Friendly Interface:** Effortlessly execute single or multiple calculations sequentially.
- **Arithmetic Operations:** Add, subtract, multiply, or divide with ease.

### Requirements

- **Operating System:** Unix-like OS (tested on macOS and Linux)
- **Crystal Version:** 1.0 or higher

### Installation

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/evilenx/calculator-cli
    ```

2. **Navigate to the Repository:**
    ```bash
    cd calculator-cli
    ```

3. **Build the Program with Crystal:**
    ```bash
    crystal build calculator-cli.cr
    ```

### Usage

Once successfully built, run the binary named `calc`:

`./calc`

The application will prompt you to enter values and choose an operation accordingly. Enjoy performing quick calculations right from your terminal!

#### Examples

Performing a calculation is straightforward:

shell

`$ ./calc Enter value 1: 4 Enter operator (+,-,*,/): + Enter value 2: 6 Result: 10.0`

Multiple calculations can also be performed sequentially:

shell

`$ ./calc Enter value 1: 8 Enter operator (+,-,*,/): * Enter value 2: 3 Result: 24.0 Enter another value (y/n)? y Enter value 1: 9 Enter operator (+,-,*,/): / Enter value 2: 3 Result: 3.0 Enter another value (y/n)? n Goodbye!`

Feel free to contribute improvements, bug fixes, or feature requests. Happy calculating!
