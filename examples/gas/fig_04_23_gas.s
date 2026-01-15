# Program to convert Celsius temperature in memory at cTemp
# to Fahrenheit equivalent in memory at fTemp

    .section .data
cTemp:
    .long 35
fTemp:
    .long 0

    .section .text
    .globl _start

_start:
    movl cTemp, %eax
    imull $9, %eax
    addl $2, %eax
    movl $5, %ebx
    cdq
    idivl %ebx
    addl $32, %eax
    movl %eax, fTemp

    # exit(0)
    movl $1, %eax      # sys_exit
    movl $0, %ebx
    int  $0x80

