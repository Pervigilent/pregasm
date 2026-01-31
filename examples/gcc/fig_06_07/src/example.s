# example.s
# Input x and y, evaluate 3*x + 7*y, display result
# GAS / gcc version

.section .data
number1:    .long 0
number2:    .long 0

prompt1:    .asciz "Enter first number x: "
prompt2:    .asciz "Enter second number y: "

string:     .space 20

resultLbl:  .asciz "3*x+7*y = "
result:     .space 11

.section .text
.globl main
.globl fctn1

# External C functions
.extern getInput
.extern showOutput
.extern atodproc
.extern dtoaproc

main:
    # input(prompt1, string, 20)
    pushl $20
    pushl $string
    pushl $prompt1
    call  getInput
    addl  $12, %esp

    # eax = atod(string)
    pushl $string
    call  atodproc
    addl  $4, %esp
    movl  %eax, number1

    # input(prompt2, string, 20)
    pushl $20
    pushl $string
    pushl $prompt2
    call  getInput
    addl  $12, %esp

    # eax = atod(string)
    pushl $string
    call  atodproc
    addl  $4, %esp
    movl  %eax, number2

    # call fctn1(number1, number2)
    pushl number2
    pushl number1
    call  fctn1
    addl  $8, %esp

    # dtoa(result, eax)
    pushl $result    
    pushl %eax
    call  dtoaproc
    addl  $8, %esp

    # showOutput(resultLbl, result)
    pushl $result
    pushl $resultLbl
    call  showOutput
    addl  $8, %esp

    xorl  %eax, %eax
    ret

# int fctn1(int x, int y)
# returns 3*x + 7*y
fctn1:
    pushl %ebp
    movl  %esp, %ebp
    pushl %ebx

    movl  8(%ebp), %eax    # x
    imull $3, %eax         # 3*x
    movl  12(%ebp), %ebx   # y
    imull $7, %ebx         # 7*y
    addl  %ebx, %eax

    popl  %ebx
    popl  %ebp
    ret


