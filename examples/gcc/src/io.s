.section .text

.globl wtoaproc
.globl dtoaproc
.globl atowproc
.globl atodproc

wtoaproc:
    pushl %ebp
    movl  %esp, %ebp

    pushl %eax
    pushl %ebx
    pushl %ecx
    pushl %edx
    pushl %edi
    pushfl

    movl  8(%ebp), %eax
    andl  $0xFFFF, %eax
    movl 12(%ebp), %edi

    cmpw  $0x8000, %ax
    jne   1f
    movb  $'-', 0(%edi)
    movb  $'3', 1(%edi)
    movb  $'2', 2(%edi)
    movb  $'7', 3(%edi)
    movb  $'6', 4(%edi)
    movb  $'8', 5(%edi)
    jmp   wtoa_exit
1:
    pushl %eax

    movb  $' ', %al
    movl  $5, %ecx
    cld
    rep stosb

    popl  %eax
    movb  $' ', %cl
    cmpw  $0, %ax
    jge   2f
    movb  $'-', %cl
    negw  %ax
2:
    movw  $10, %bx
3:
    movw  $0, %dx
    divw  %bx
    addb  $'0', %dl
    movb  %dl, (%edi)
    decl  %edi
    cmpw  $0, %ax
    jne   3b

    movb  %cl, (%edi)

wtoa_exit:
    popfl
    popl %edi
    popl %edx
    popl %ecx
    popl %ebx
    popl %eax
    popl %ebp
    ret

dtoaproc:
    pushl %ebp
    movl  %esp, %ebp

    pushl %eax
    pushl %ebx
    pushl %ecx
    pushl %edx
    pushl %edi
    pushfl

    movl  8(%ebp), %eax
    movl 12(%ebp), %edi

    cmpl  $0x80000000, %eax
    jne   1f
    movb  $'-', 0(%edi)
    movb  $'2', 1(%edi)
    movb  $'1', 2(%edi)
    movb  $'4', 3(%edi)
    movb  $'7', 4(%edi)
    movb  $'4', 5(%edi)
    movb  $'8', 6(%edi)
    movb  $'3', 7(%edi)
    movb  $'6', 8(%edi)
    movb  $'4', 9(%edi)
    movb  $'8',10(%edi)
    jmp   dtoa_exit
1:
    pushl %eax

    movb  $' ', %al
    movl  $10, %ecx
    cld
    rep stosb

    popl  %eax
    movb  $' ', %cl
    cmpl  $0, %eax
    jge   2f
    movb  $'-', %cl
    negl  %eax
2:
    movl  $10, %ebx
3:
    movl  $0, %edx
    divl  %ebx
    addb  $'0', %dl
    movb  %dl, (%edi)
    decl  %edi
    cmpl  $0, %eax
    jne   3b

    movb  %cl, (%edi)

dtoa_exit:
    popfl
    popl %edi
    popl %edx
    popl %ecx
    popl %ebx
    popl %eax
    popl %ebp
    ret

atowproc:
    pushl %ebp
    movl  %esp, %ebp
    subl  $2, %esp

    pushl %ebx
    pushl %edx
    pushl %esi
    pushfl

    movl  8(%ebp), %esi
1:
    cmpb  $' ', (%esi)
    jne   2f
    incl  %esi
    jmp   1b
2:
    movw  $1, %ax
    cmpb  $'+', (%esi)
    je    3f
    cmpb  $'-', (%esi)
    jne   4f
    movw  $-1, %ax
3:
    incl  %esi
4:
    movw  %ax, -2(%ebp)
    xorw  %ax, %ax
5:
    cmpb  $'0', (%esi)
    jl    6f
    cmpb  $'9', (%esi)
    jg    6f
    imulw $10, %ax
    movb  (%esi), %bl
    andw  $0x000F, %bx
    addw  %bx, %ax
    incl  %esi
    jmp   5b
6:
    cmpw  $0x8000, %ax
    jnb   7f
    imulw -2(%ebp)
7:
    popfl
    popl %esi
    popl %edx
    popl %ebx
    movl  %ebp, %esp
    popl  %ebp
    ret

atodproc:
    pushl %ebp
    movl  %esp, %ebp
    subl  $4, %esp

    pushl %ebx
    pushl %edx
    pushl %esi
    pushfl

    movl  8(%ebp), %esi
1:
    cmpb  $' ', (%esi)
    jne   2f
    incl  %esi
    jmp   1b
2:
    movl  $1, %eax
    cmpb  $'+', (%esi)
    je    3f
    cmpb  $'-', (%esi)
    jne   4f
    movl  $-1, %eax
3:
    incl  %esi
4:
    movl  %eax, -4(%ebp)
    xorl  %eax, %eax
5:
    cmpb  $'0', (%esi)
    jl    6f
    cmpb  $'9', (%esi)
    jg    6f
    imull $10, %eax
    movb  (%esi), %bl
    andl  $0x0000000F, %ebx
    addl  %ebx, %eax
    incl  %esi
    jmp   5b
6:
    cmpl  $0x80000000, %eax
    jnb   7f
    imull -4(%ebp)
7:
    popfl
    popl %esi
    popl %edx
    popl %ebx
    movl  %ebp, %esp
    popl  %ebp
    ret

