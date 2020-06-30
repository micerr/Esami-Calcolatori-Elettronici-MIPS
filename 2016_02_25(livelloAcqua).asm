.data
orario: .word 	0, 	12, 	51, 	112, 	200, 	384
livello: .word 	-5, 	46, 	70, 	38, 	-12, 	49
minuti: .word 63
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,orario
	la $a1,livello
	lw $a2,minuti
	jal livelloAcqua
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main

.globl livelloAcqua
.ent livelloAcqua
livelloAcqua:
	li $v0,0
	li $s0,-1
loop:
	addi $s0,$s0,1
	lw $t0,($a0)
	addi $a0,$a0,4
	bne $a2,$t0,continua
	mul $s0,$s0,4
	add $s0,$s0,$a1
	lw $v0,($s0)
	b fine
continua:
	ble $a2,$t0,loop
	lw $t1,($a0)
	bgt $a2,$t1,loop
	mul $s0,$s0,4
	add $s0,$s0,$a1
	lw $t2,($s0)
	addi $s0,$s0,4
	lw $t3,($s0)
	sub $a2,$a2,$t0
	sub $t3,$t3,$t2
	mul $a2,$a2,$t3
	sub $t0,$t1,$t0
	div $a2,$t0
	mflo $t0
	add $v0,$t2,$t0
fine:
	jr $ra
.end livelloAcqua