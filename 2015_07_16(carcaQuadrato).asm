DIM=9
.data
mat:	.byte	0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 1, 1, 0, 0, 0
		.byte 0, 0, 0, 0, 1, 1, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 1, 1, 1, 0, 0, 0, 0
		.byte 0, 0, 1, 1, 1, 0, 0, 0, 0
		.byte 0, 0, 1, 1, 1, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 1, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	li $a0,48
	la $a1,mat
	jal cercaQuadrato
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl cercaQuadrato
.ent cercaQuadrato
cercaQuadrato:
	li $v0, 0
	li $t0,DIM
	div $a0,$t0
	mflo $t0
	mfhi $t1
	blt $t0,2,fine
	li $t2,DIM
	addi $t2,$t2,-3
	bgt $t0,$t2,fine
	blt $t1,2,fine
	bgt $t1,$t2,fine
	li $t0,DIM
	sub $a0,$a0,$t0
	addi $a0,$a0,-1
	add $a1,$a0,$a1
	li $t2,0
loop:
	li $t3,0
	loop1:
		lb $t0,($a1)
		addi $a1,$a1,1
		beq $t0,$0,fine
		addi $t3,$t3,1
		bne $t3,3,loop1
	addi $a1,$a1,DIM
	addi $a1,$a1,-3
	addi $t2,$t2,1
	bne $t2,3,loop
	li $v0,1
fine:
	jr $ra
.end cercaQuadrato