# program to search for one string embedded in another
# GAS / gcc version

.section .data
prompt1:    .asciz "String to search?"
prompt2:    .asciz "Key to search for?"

target:     .space 80
key:        .space 80

trgtLength: .long 0
keyLength:  .long 0
lastPosn:   .long 0

resultLbl:  .asciz "Search Results"
failure:    .asciz "The key does not appear in the string"
success:    .asciz "The key appears at position"

position:   .space 11
            .asciz "   in the string."

.section .text
.globl main
.globl strlen

.extern getInput
.extern showOutput
.extern dtoaproc

# ---------------------------------------------
# main program
# ---------------------------------------------
main:
    # input(prompt1, target, 80)
    pushl $80
    pushl $target
    pushl $prompt1
    call  getInput
    addl  $12, %esp

    # strlen(target)
    pushl $target
    call  strlen
    addl  $4, %esp
    movl  %eax, trgtLength

    # input(prompt2, key, 80)
    pushl $80
    pushl $key
    pushl $prompt2
    call  getInput
    addl  $12, %esp

    # strlen(key)
    pushl $key
    call  strlen
    addl  $4, %esp
    movl  %eax, keyLength

    # lastPosn = trgtLength - keyLength + 1
    movl  trgtLength, %eax
    subl  keyLength, %eax
    incl  %eax
    movl  %eax, lastPosn

    cld                     # forward string direction
    movl  $1, %eax          # starting position

whilePosn:
    cmpl  lastPosn, %eax
    jg    endWhilePosn

    leal  target, %esi
    addl  %eax, %esi
    decl  %esi

    leal  key, %edi
    movl  keyLength, %ecx

    repe  cmpsb
    je    found

    incl  %eax
    jmp   whilePosn

endWhilePosn:
    pushl $failure
    pushl $resultLbl
    call  showOutput
    addl  $8, %esp
    jmp   quit

found:
    pushl %eax
    pushl $position
    call  dtoaproc
    addl  $8, %esp

    pushl $success
    pushl $resultLbl
    call  showOutput
    addl  $8, %esp

quit:
    xorl  %eax, %eax
    ret

# ---------------------------------------------
# strlen(char *str)
# ---------------------------------------------
strlen:
    pushl %ebp
    movl  %esp, %ebp
    pushl %ebx

    xorl  %eax, %eax
    movl  8(%ebp), %ebx

whileChar:
    cmpb  $0, (%ebx)
    je    endWhileChar
    incl  %eax
    incl  %ebx
    jmp   whileChar

endWhileChar:
    popl  %ebx
    popl  %ebp
    ret

