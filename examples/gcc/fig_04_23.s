# Program to convert Celsius temperature in memory at cTemp
# to Fahrenheit equivalent in memory at fTemp

    .section .data
    .align 4
cTemp:
    .long 35          # Celsius temperature
fTemp:
    .long 0           # Fahrenheit temperature (uninitialized in MASM)

    .section .text
    .globl main
    .type main, @function

main:
    movl cTemp, %eax      # eax = cTemp
    imull $9, %eax        # eax = eax * 9
    addl $2, %eax         # rounding factor
    movl $5, %ebx         # divisor = 5
    cdq                   # sign-extend eax into edx:eax
    idivl %ebx            # eax = (edx:eax) / ebx
    addl $32, %eax        # eax += 32
    movl %eax, fTemp      # fTemp = eax

    movl $0, %eax         # return 0
    ret

