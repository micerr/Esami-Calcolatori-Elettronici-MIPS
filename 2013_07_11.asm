DIM= 5
N= DIM - 1
.data
matrix: 	.word 	1,	0,	0,	0,	0
			.word	0,	2,	0,	1,	0
			.word	0,	0,	3,	0,	0
			.word	0,	1,	0,	4,	0
			.word	0,	0,	0,	0,	5
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,matrix
	jal valmatr
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra	
.end main
.globl valmatr
.ent valmatr
valmatr:
	li $v0,2
	li $s0,0		# I
	li $s1,1		# J
loop:
	loop1:
		mul $t0,$s0,DIM
		add $t0,$t0,$s1
		mul $t0,$t0,4
		add $t0,$t0,$a0
		lw $t0,($t0)
		beq $t0,$0,continue
		li $v0,1
	continue:
		mul $t1,$s1,DIM
		add $t1,$t1,$s0
		mul $t1,$t1,4
		add $t1,$t1,$a0
		lw $t1,($t1)
		beq $t0,$t1,continue1
		li $v0,0
		b fine
	continue1:
		addi $s1,$s1,1
		bne $s1,DIM,loop1
	addi $s0,$s0,1
	addi $s1,$s0,1
	bne $s0,N,loop
fine:
	jr $ra
.end valmatr