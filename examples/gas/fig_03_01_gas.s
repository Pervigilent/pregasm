    .section .data
number:
    .long   -105          # DWORD = 32-bit signed integer
sum:
    .long   0

    .section .text
    .globl  _start

_start:
    movl    number, %eax  # eax = number
    addl    $158, %eax    # eax += 158
    movl    %eax, sum     # sum = eax

    movl    $1, %eax     # sys_exit
    xorl    %ebx, %ebx   # exit code 0
    int     $0x80

