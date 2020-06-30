DIM=4
.data
scaglione: .word 0, 15000, 28000, 55000
aliquota: .word 23, 27, 38, 41
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,scaglione
	la $a1,aliquota
	li $a2, 23000
	jal imposta
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl imposta
.ent imposta
imposta:
	li $v0,0
	lw $t0,4($a0) 
	lw $t1,8($a0) 
	lw $t2,12($a0)
	
	lw $t3,($a1)
	lw $t4,4($a1)
	lw $t5,8($a1)
	lw $t6,12($a1)
	
	bgt $a2,$t0,secondo
	mul $t7,$t3,$a2
	div $t7,$t7,100
	add $v0,$v0,$t7
	j fine
secondo:

	mul $t7,$t3,$t0
	div $t7,$t7,100
	add $v0,$v0,$t7
	bgt $a2,$t1,terzo
	sub $t7,$a2,$t0
	mul $t7,$t4,$t7
	div $t7,$t7,100
	add $v0,$v0,$t7
	j fine
terzo:
	sub $t7,$t1,$t0
	mul $t7,$t4,$t7
	div $t7,$t7,100
	add $v0,$v0,$t7
	bgt $a2,$t2,quarto
	sub $t7,$a2,$t1
	mul $t7,$t5,$t7
	div $t7,$t7,100
	add $v0,$v0,$t7
	j fine
quarto:
	sub $t7,$t2,$t1
	mul $t7,$t5,$t7
	div $t7,$t7,100
	sub $t7,$a2,$t2
	mul $t7,$t6,$t7
	div $t7,$t7,100
	add $v0,$v0,$t7
fine:
	jr $ra
.end imposta