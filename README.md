# pregasm
Pre GNU Assembler Code Bank

## Introduction
This is an x86 assembly code base. It currently houses the assembly language examples from Richard Detmer's assembly language book. I called it pre-gasm because I may have considered writing an assembler and this being the preliminary code base for that. However, I will probably just make it a repository for the things listed in tasks and rename it.

## Tasks
I have the following objectives for this repository
- Assembly implementation of leet code
- Translation of Detmer's source for GNU assembler
- Implementation of inline assembly
- Implementation of parallel algorithms using inline assembly and OpenMP
- Use of CMake for building projects
- Implementation of numerical methods

## GAS Projects
The following gas examples are available:
\[TODO: Complete list of gas examples\]

The GNU assembler can be tested for and installed with the following commands.
```
as --version
sudo apt update
sudo apt install binutils
```

To build the first example, run the following commands in bash which assembles and then links the code.
```
as --32 fig_03_01_gas.s -o fig_03_01_gas.o
ld -m elf_i386 fig_03_01_gas.o -o fig_03_01_gas
./fig_03_01_gas
```

## GCC Projects
The following gcc examples are available
- fig_03_11
    - Adds two numbers
- fig_04_18
    - Computes area of rectangle

The 32-bit Visual Studio project corresponds to fig_03_11 and was translated for use in Linux as a CMake build using gcc in the 'gcc/fig_03_11' folder. gas, gcc, and cmake were installed with
```
sudo apt update
sudo apt install build-essential
sudo apt install gcc-multilib
sudo apt install cmake
```

To build the project, we use the following commands
```
mkdir build
cd build/
cmake ..
make
./fig_03_11 
```





