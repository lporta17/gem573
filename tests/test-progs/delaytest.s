.section .text
.globl _start

_start:
    # load initial vals
    li x10, 0x123456789ABC
    # Load a 64-bit key into x11
    li x11, 0xDEADC0DEBEEFCAFE

    #spam noops just to have instructions
    nop
    nop
    nop
    nop
    nop

    #perform the pac
    .insn r 0x0b, 0x2, 0x0, x12, x10, x11

    #more noops
    nop
    nop
    nop

    # Exit syscall for gem5 SE mode
    li a7, 93           # exit(0)
    li a0, 0
    ecall
