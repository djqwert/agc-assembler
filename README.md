# AGC assembler
This project presents an Assembler for assembly code of Apollo Guidance Computer.

AGC assembler is used to assembly code for [AGC emulator](https://github.com/djqwert/agc-emulator).

Features:
  - two phases assembler
  - error detenction is provided
  - data section comes before the code section
  - constants and variables inside data section, and constants comes before variables
  - constants, variables and code addressing can be managed using counter
  - four tables are formed: jump table, symbol table, data table and register table
  - there is an example of assembly code in code.as used to fetch assembly instructions
  - at the end comes generated a list file with the log of assembling and the file object named binaryCode.cc
  - don't forget to redefine parameters at the begin of asm.cc file as you need and interrupt address if you are using AGC emulator

# Installation
To build project:

```sh
make
```
To execute project:

```sh
./asm -il
```

# Issue

This project has been developed very fast - just in three days! - for fun and to understand how is made an assembler; another reason is to create a method to support an easly programming for AGC emulator, then I know you'll find ugly static tables to manage assembly code (no dinamic memory allocation).
Another problem in this project is the O(n^2) complexity to search data in tables and replace labels inside assembly code, obviusly is possible to reduce computation complexity using STL kit or other tools avaible in C.

# Contributors
[Antonio Di Tecco](https://github.com/djqwert)
