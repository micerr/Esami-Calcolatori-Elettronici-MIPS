DIMX=8	#RIGHE
DIMY=10	#COLONNE
.data
matrice: 	.byte 0, 0, 1, 0, 0, 1, 1, 0, 1, 0
				.byte 0, 1, 1, 0, 0, 0, 1, 0, 1, 1
				.byte 1, 1, 0, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 0, 1, 1, 0, 1, 0
				.byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
				.byte 1, 1, 1, 0, 0, 1, 1, 1, 1, 1
				.byte 1, 1, 1, 0, 1, 1, 1, 1, 1, 0
				.byte 1, 1, 0, 1, 1, 1, 1, 0, 1, 0
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,matrice
	li $a1,DIMX
	li $a2,DIMY
	jal valuta1
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl valuta1
.ent valuta1
valuta1:
	li $v0,0
	li $t0,0 #colonna
	loop:
		li $t1,0 #riga
		loop1:
			mul $t2,$t1,$a2
			add $t2,$t2,$t0
			add $t2,$t2,$a0
			lb $t2,($t2)
			beq $t2,$0,no
			addi $t1,$t1,1
			bne $t1,$a1,loop1
			addi $v0,$v0,1
		no:
			addi $t0,$t0,1
		bne $t0,$a2,loop
	jr $ra
.end valuta1