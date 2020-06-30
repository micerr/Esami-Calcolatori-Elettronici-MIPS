NRIGHE=4
NCOLONE=6
.data
matrice: 	.byte 113, 10, 95, 20, 60, 10
				.byte 51, 26, 120, 30, 56, 13
				.byte 102, 171, 21, 111, 17, 22
				.byte 204, 100, 230, 16, 76, 34
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,matrice
	jal contaColonne
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl contaColonne
.ent contaColonne
contaColonne:
	li $t0,0
	li $v0,0
loop:
	li $t1,0
	li $s0,0 # Pari
	li $s1,0 # Dispari
	addi $t4,$a0,1
	loop1:
		lbu $t2,($a0)
		addi $a0,$a0,NCOLONE
		and $t3,$t2,1
		beq $t3,1,dispari
		add $s0,$s0,1
		b next
	dispari:
		add $s1,$s1,1
	next:
		addi $t1,$t1,1
		bne $t1,NRIGHE,loop1
	move $a0,$t4
	ble $s0,$s1,salta
	addi $v0,$v0,1
salta:
	addi $t0,$t0,1
	bne $t0,NCOLONE,loop
	jr $ra
.end contaColonne