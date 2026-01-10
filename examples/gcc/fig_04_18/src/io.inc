    .extern getInput
    .extern showOutput
    .extern atodproc
    .extern dtoaproc
    .extern wtoaproc
    .extern atowproc

/*
 *********************************************************************************
 * Name:	dtoa
 * Paramter(s):	destination, source
 * Action:	Converts the doubleword at source (register or memeory) to an 11-
 * 		byte-long ASCII string at destination.
 *********************************************************************************
 */
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

/*
 *********************************************************************************
 * Name:	atod
 * Paramter(s):	source
 * Action:	Scans the string starting at source for + or - followed by digits,
 * 		interpreting these characters as an integer. The corresponding
 *		2's complement number is put in EAX.
 *********************************************************************************
 */
.macro atod source
    leal  \source, %eax
    pushl %eax
    call  atodproc
    addl  $4, %esp
.endm

/*
 *********************************************************************************
 * Name:	wtoa
 * Paramter(s):	destination [dest], source
 * Action:	Converts the word at source (register or memeory) to a 6-byte long
 * 		ASCII string at destination.
 *********************************************************************************
 */
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

/*
 *********************************************************************************
 * Name:	atow
 * Paramter(s):	source
 * Action:	Similar to atod, except that the resulting number is placed in
 * 		AX.
 *********************************************************************************
 */
.macro atow source
    leal  \source, %eax
    pushl %eax
    call  atowproc
    addl  $4, %esp
.endm

/*
 *********************************************************************************
 * Name:	output
 * Paramter(s):	labelMsg [outLbl], valueMsg [outStr]
 * Action:	Generates a message box [standard output prompt] with the label 
 * 		labelMsg [outLbl], and valueMsg [outStr] in the message area. Each
 *		of labelMsg [outLbl] and valueMsg [outStr] references a string in
 *		the data segment.
 *********************************************************************************
 */
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

/*
 *********************************************************************************
 * Name:	input
 * Paramter(s):	prompt [inPrompt], destination [inStr], length [maxLength]
 * Action:	Genertes a dialog box [standard output prompt] with label
 * 		specified by prompt [inPrompt], where prompt [inPrompt] references
 *		a string in the data segment. When OK [enter] is preseed, up to
 *		length characters are copied from the dialog box to memory at
 *		destination [inStr]
 *********************************************************************************
 */
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

