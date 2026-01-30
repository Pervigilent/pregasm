.section .data
number1:    .long 0
number2:    .long 0

prompt1:    .asciz "Enter first number: "
prompt2:    .asciz "Enter second number: "

string:     .space 40

resultLbl:  .asciz "The sum is "
sum:        .space 12

.section .text
.globl main

# external C functions
.extern getInput
.extern showOutput
.extern atodproc
.extern dtoaproc

main:
    # input(prompt1, string, 40)
    pushl $40
    pushl $string
    pushl $prompt1
    call  getInput
    addl  $12, %esp

    # atod(string)
    pushl $string
    call  atodproc
    addl  $4, %esp
    movl  %eax, number1

    # input(prompt2, string, 40)
    pushl $40
    pushl $string
    pushl $prompt2
    call  getInput
    addl  $12, %esp

    pushl $string
    call  atodproc
    addl  $4, %esp
    movl  %eax, number2

    # eax = number1 + number2
    movl  number1, %eax
    addl  number2, %eax

    # dtoaproc(source, dest)
    pushl $sum
    pushl %eax
    call  dtoaproc
    addl  $8, %esp

    # output(resultLbl, sum)
    pushl $sum
    pushl $resultLbl
    call  showOutput
    addl  $8, %esp

    xorl  %eax, %eax
    ret

