### **Calculator-cli**

### A Simple Command Line Calculator

This small CLI tool allows you to perform basic arithmetic operations such as addition, subtraction, multiplication, and division directly from the command line.

#### Features

- Easy-to-use interface
- Perform single or multiple calculations sequentially
- Supports addition, subtraction, multiplication, and division

#### Requirements

- A Unix-like operating system (tested on macOS and Linux)
- Crystal programming language installed (version >= 1.0)

#### Installation

First, clone the repository onto your local machine:

bash

`git clone https://github.com/evilenx

Next, change directories to the cloned repo:

bash

`cd calculator-cli`

Finally, build the program using Crystal:

bash

`crystal build calculator-cli.cr`

#### Usage

Once built successfully, run the generated binary called `calc`:

bash

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
