DIM =4
.data
mat1: 	.byte 1, 2, 3, 4
			.byte 5, 6, 7, 8
			.byte 9, 10, 11, 12
			.byte 13, 14, 15, 16
mat2: 	.byte 9, 3, 4, 11
			.byte 1, 5, 6, 8
			.byte 16, 15, 2, 12
			.byte 7, 10, 13, 14
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0, mat1
	la $a1,mat2
	li $a2, 1
	li $a3, 3
	jal trova_num
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl trova_num
.ent trova_num
trova_num:
	li $v0,-1
	mul $t0,$a2,DIM
	add $a0,$a0,$t0
	mul $t0,$a3,DIM
	add $a1,$a1,$t0
	li $t0,0
	li $s0,0
loop:
	li $t1,0
	lb $s0,($a0)
	addi $a0,$a0,1
	loop1:
		lb $s1,($a1)
		addi $a1,$a1,1
		beq $s0,$s1,fine
		addi $t1,$t1,1
		bne $t1,DIM,loop1
	addi $a1,$a1,-4
	addi $t0,$t0,1
	bne $t0,DIM,loop
fine:
	move $v0,$s0
	jr $ra
.end trova_num