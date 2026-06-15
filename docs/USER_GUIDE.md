# Nalculator User Guide

Welcome to **Nalculator**, the fast, native calculator powered by GTK4 and Nitpick!

## Building and Installing

Nalculator is built using the `npkbld` package manager and compiler suite for the Nitpick language.

### Prerequisites
- `npkbld` and the Nitpick compiler.
- GTK4 development libraries (`libgtk-4-dev`).

### Build Instructions
To build Nalculator from source, simply run the following command in the root directory:

```bash
/path/to/npkbld build nalculator
```

The compiled binary will be placed at `./.nitpick_make/build/nalculator`.

### Running Tests
To run the automated tests covering the Lexer, Parser, FSM logic, and Main Harness:
```bash
make test
```

## Features and Usage

- **Standard Calculations**: Supports standard arithmetic `+`, `-`, `*`, `/`.
- **Scientific Functions**: Supports trigonometric functions (`sin`, `cos`, `tan`), logarithms (`log`, `ln`), exponential functions (`^`, `sqrt`), and mathematical constants (`pi`, `e`).
- **Memory Storage**:
  - `MC`: Memory Clear.
  - `MR`: Memory Recall.
  - `M+`: Add current result to memory.
  - `M-`: Subtract current result from memory.
  - `MS`: Store current result in memory.
- **Global Keyboard Shortcuts**: Type naturally! Standard keyboard inputs map to the UI.
- **Clipboard Integration**:
  - `Ctrl+C`: Copy the current expression/result to the clipboard.
  - `Ctrl+V`: Paste text from the clipboard seamlessly.

Enjoy lightning-fast computations!
