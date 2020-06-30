NUM=6			# Massimo 500
SAC=2			# Massimo 5
.data
list:	.word 4, 99, 0
		.word 16, 49, 0
		.word 2, 86, 1
		.word 3, 48, 1
		.word 8, 99, 0
		.word 4, 21, 1
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,list
	li $a1,NUM
	li $a2,SAC
	jal totale
	move $t0,$v0
	move $t1,$v1
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,','
	li $v0,11
	syscall
	move $a0,$t1
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl totale
.ent totale
totale:
	li $t0,0 #contatore righe
	li $v0,0 #somma euro
	li $v1,0 #somma centesimi
loop:
	lw $s0,($a0)
	lw $s1,4($a0)
	lw $s2,8($a0)
	addi $a0,$a0,12
	add $v0,$v0,$s0
	add $v1,$v1,$s1
	bne $s2,1,salta
	add $v1,$v1,$a2
salta:
	addi $t0,$t0,1
	bne $t0,$a1,loop
	li $t0,100
	divu $v1,$t0
	mfhi $v1
	mflo $t0
	add $v0,$v0,$t0
	jr $ra
.end totale