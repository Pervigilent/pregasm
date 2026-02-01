    .extern getInput
    .extern showOutput
    .extern atodproc
    .extern dtoaproc
    .extern wtoaproc
    .extern atowproc

.macro dtoa dest, source
    pushl %ebx
    leal  \dest, %ebx
    pushl %ebx
    movl  \source, %ebx
    pushl %ebx
    call  dtoaproc
    addl  $8, %esp
    popl  %ebx
.endm

.macro atod source
    leal  \source, %eax
    pushl %eax
    call  atodproc
    addl  $4, %esp
.endm

.macro wtoa dest, source
    pushl %ebx
    leal  \dest, %ebx
    pushl %ebx
    movw  \source, %bx
    pushl %ebx
    call  wtoaproc
    addl  $8, %esp
    popl  %ebx
.endm

.macro atow source
    leal  \source, %eax
    pushl %eax
    call  atowproc
    addl  $4, %esp
.endm

.macro output outLbl, outStr
    pushal
    cld
    leal  \outStr, %eax
    pushl %eax
    leal  \outLbl, %eax
    pushl %eax
    call  showOutput
    addl  $8, %esp
    popal
.endm

.macro input inPrompt, inStr, maxLength
    pushal
    movl  \maxLength, %ebx
    pushl %ebx
    leal  \inStr, %ebx
    pushl %ebx
    leal  \inPrompt, %ebx
    pushl %ebx
    call  getInput
    addl  $12, %esp
    popal
.endm

