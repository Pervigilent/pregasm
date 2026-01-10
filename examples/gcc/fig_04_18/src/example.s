# example.s
# Program: Area of a rectangle
# Author: R. Detmer (translated to GAS / Linux)
# Target: 32-bit x86, GCC, cdecl

.section .data
length:     .long 0
width:      .long 0

prompt1:    .asciz "Length of rectangle? "
prompt2:    .asciz "Width of rectangle? "

string:     .space 30

areaLbl:    .asciz "The area is "
area:       .space 12          # 11 chars + NUL safety

.section .text
.globl main

.extern getInput
.extern showOutput
.extern atodproc
.extern dtoaproc

main:
    # input(prompt1, string, 30)
    pushl $30
    pushl $string
    pushl $prompt1
    call  getInput
    addl  $12, %esp

    # atod(string) → eax
    pushl $string
    call  atodproc
    addl  $4, %esp
    movl  %eax, length

    # input(prompt2, string, 30)
    pushl $30
    pushl $string
    pushl $prompt2
    call  getInput
    addl  $12, %esp

    # atod(string) → eax
    pushl $string
    call  atodproc
    addl  $4, %esp
    movl  %eax, width

    # eax = length * width
    movl  length, %eax
    mull  width              # unsigned multiply: EDX:EAX = EAX * width

    # dtoaproc(source, dest)
    pushl $area               # dest
    pushl %eax                # source
    call  dtoaproc
    addl  $8, %esp

    # showOutput(areaLbl, area)
    pushl $area
    pushl $areaLbl
    call  showOutput
    addl  $8, %esp

    xorl  %eax, %eax
    ret

.section .note.GNU-stack,"",@progbits


