.section .text
.globl _start

_start:
    # load initial vals
    li x10, 0x123456789ABC
    # Load a 64-bit key into x11
    li x11, 0xDEADC0DEBEEFCAFE

    #perform the pac
    .insn r CUSTOM_0, 0x0, 0x0, x12, x10, x11

    #verify the pac
    .insn r CUSTOM_1, 0x0, 0x0, x13, x12, x11

    # Exit syscall for gem5 SE mode
    li a7, 93           # exit(0)
    li a0, 0
    ecall