# AGC assembler
This project presents an Assembler for the assembly code of Apollo Guidance Computer.

AGC assembler is used to assemble code for [AGC emulator](https://github.com/djqwert/agc-emulator).

Features:
  - two phases assembler
  - error detection is provided
  - data section comes before code section
  - constants and variables inside the data section, and constants come before variables
  - constants, variables, and code addressing can be managed using counter
  - four tables are formed: jump table, symbol table, data table and register table
  
Extra:
  - there is an example of assembly code in code.as used to fetch assembly instructions
  - at the end comes a list file with the log of assembling and the file object named binaryCode.cc
  - don't forget to redefine parameters at the beginning of asm.cc file as you need, and the interrupt address if you are using AGC emulator

# Installation
To build the project:

```sh
make
```
To execute project:

```sh
./asm -il
```

# Issues

This project has been developed very fast - just in three days! - for fun and to understand how an assembler is made; another reason is to create a method to support easy programming for AGC emulator; then I know you'll find ugly static tables to manage assembly code (no dynamic memory allocation). Another problem in this project is the O(n^2) complexity of searching data in tables and replacing labels inside assembly code. It is obviously possible to reduce computation complexity using STL kit available in C.

# Contributors
[Antonio Di Tecco](https://github.com/djqwert)
