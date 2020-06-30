DIM = 4
.data
matrice: 	.word 126, -988, 65, 52
				.word 7, 0, 2, 643
				.word 66, 532, 43, 9254
				.word 5, -51, 4352, -452
.text
.globl main
.ent main
main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, matrice
	li $a1, DIM
	jal calcolaTrasp
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
.end main	
.globl calcolaTrasp
.ent calcolaTrasp
calcolaTrasp:
	li $t0,0 	# Riga i
	li $t1,1	# Colonna j
loop:
	loop1:
		mul $s0,$t0,$a1
		add $s0,$s0,$t1
		mul $s0,$s0,4		# Offset 1
		mul $s1,$t1,$a1
		add $s1,$s1,$t0
		mul $s1,$s1,4		# Offset 1
		add $s0,$s0,$a0
		lw $s2,($s0)
		add $s1,$s1,$a0
		lw $s3,($s1)
		sw $s2,($s1)
		sw $s3,($s0)
		addi $t1,$t1,1
		bne $t1,$a1,loop1
	addi $t1,$t1,-2
	add $t1,$t1,$t0
	addi $t0,$t0,1
	bne $t1,$a1,loop
	jr $ra
.end calcolaTrasp