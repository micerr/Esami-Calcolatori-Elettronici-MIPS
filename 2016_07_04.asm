N=5
M=4
SPAZIO=M*4
.data
matrice: 	.word	20,	35,	40,	12
				.word	26,	5,		18,	30
				.word	10,	45,	33,	58
				.word	47,	3,		35,	34
				.word	60,	45,	32,	43
vettore:		.space SPAZIO
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0, matrice
	la $a1, vettore
	jal calcola_e_invia_media
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main

.globl calcola_e_invia_media
.ent calcola_e_invia_media
calcola_e_invia_media:
	li $t0, 0		#colonna
loop:
	li $t1,0 		#riga
	li $s0, 0	# somma
	loop1:
		add $t2,$t0,$0
		mul $t3,$t1,M
		add $t2,$t2,$t3
		mul $t2,$t2,4
		add $t2,$t2,$a0
		lw $t2,($t2)
		add $s0,$s0,$t2
		addi $t1,$t1,1
		bne $t1,N,loop1
	li $t1,N
	div $s0,$t1
	mflo $s0
	mul $t1,$t0,4
	add $t1,$a1,$t1
	sw $s0,($t1)
	addi $t0,$t0,1
	bne $t0,M,loop
	jr $ra
.end calcola_e_invia_media