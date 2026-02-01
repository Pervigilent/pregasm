.section .data
prompt1:   .asciz "String? "
prompt2:   .asciz "Character? "
label1:    .asciz "Rest of the string: "

string:    .space 80
charbuf:   .space 5


.section .text
.globl main
.extern getInput
.extern showOutput
.extern strlen

main:
    # input(prompt1, string, 80)
    pushl $80
    pushl $string
    pushl $prompt1
    call  getInput
    addl  $12, %esp

    # strlen(string)
    pushl $string
    call  strlen
    addl  $4, %esp

    incl  %eax            # include null terminator
    movl  %eax, %ecx      # ECX = length

    # input(prompt2, charbuf, 5)
    pushl $5
    pushl $charbuf
    pushl $prompt2
    call  getInput
    addl  $12, %esp

    movb  charbuf, %al    # AL = character to find
    leal  string, %edi    # EDI = &string
    cld                   # forward scanning

    repne scasb           # scan for AL

    decl  %edi            # back up to match

    # showOutput(label1, edi)
    pushl %edi
    pushl $label1
    call  showLabeledOutput
    addl  $8, %esp

    xorl  %eax, %eax
    ret

