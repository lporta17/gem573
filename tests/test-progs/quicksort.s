	.file	"quicksort.c"
	.option nopic
	.option norelax
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	swap
	.type	swap, @function
swap:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-40(s0)
	lw	a5,0(a5)
	sw	a5,-20(s0)
	ld	a5,-48(s0)
	lw	a4,0(a5)
	ld	a5,-40(s0)
	sw	a4,0(a5)
	ld	a5,-48(s0)
	lw	a4,-20(s0)
	sw	a4,0(a5)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	swap, .-swap
	.align	1
	.globl	partition
	.type	partition, @function
partition:
	addi	sp,sp,-48
	.insn r CUSTOM_0, 0x0, 0x0, ra, zero, ra
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	mv	a4,a2
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-48(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
	lw	a5,-44(s0)
	sw	a5,-24(s0)
	j	.L3
.L5:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-28(s0)
	sext.w	a5,a5
	blt	a5,a4,.L4
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a3,a4,a5
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	mv	a1,a5
	mv	a0,a3
	call	swap
.L4:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L3:
	lw	a4,-48(s0)
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgt	a4,a5,.L5
	lw	a5,-20(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a3,a4,a5
	lw	a5,-48(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	mv	a1,a5
	mv	a0,a3
	call	swap
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	mv	a0,a5
	ld	ra,40(sp)
	.insn r CUSTOM_1, 0x0, 0x0, ra, zero, ra
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	partition, .-partition
	.align	1
	.globl	quickSort
	.type	quickSort, @function
quickSort:
	addi	sp,sp,-48
	.insn r CUSTOM_0, 0x0, 0x0, ra, zero, ra
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	mv	a4,a2
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a4,-44(s0)
	lw	a5,-48(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L9
	lw	a4,-48(s0)
	lw	a5,-44(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	partition
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lw	a5,-44(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	quickSort
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	lw	a4,-48(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	quickSort
.L9:
	nop
	ld	ra,40(sp)
	.insn r CUSTOM_1, 0x0, 0x0, ra, zero, ra
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	quickSort, .-quickSort
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-416
	.insn r CUSTOM_0, 0x0, 0x0, ra, zero, ra
	sd	ra,408(sp)
	sd	s0,400(sp)
	addi	s0,sp,416
	sw	zero,-20(s0)
	j	.L11
.L12:
	call	rand
	mv	a5,a0
	andi	a5,a5,1023
	sext.w	a4,a5
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a3,s0,-16
	add	a5,a3,a5
	sw	a4,-400(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L11:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,98
	ble	a4,a5,.L12
	addi	a5,s0,-416
	li	a2,98
	li	a1,0
	mv	a0,a5
	call	quickSort
	li	a5,0
	mv	a0,a5
	ld	ra,408(sp)
	.insn r 0x33, 0, 0, a0, a1, a2
	.insn r CUSTOM_1, 0, 0, ra, zero, ra
	ld	s0,400(sp)
	addi	sp,sp,416
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 9.2.0"
