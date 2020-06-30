DIM=4
SPACE=DIM*4
.data
prezzo_acq: .word 190, 68, 71, 84
prezzo_vend: .word 199, 40, 81, 90
dividendo: .word 2, 5, 0, 1
rendim: .space SPACE
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,prezzo_acq
	la $a1,prezzo_vend
	la $a2,dividendo
	la $a3,rendim
	jal rendimento
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl rendimento
.ent rendimento
rendimento:
	li $t0,0
loop:
	lw $t1,($a0)
	addi $a0,$a0,4
	lw $t2,($a1)
	addi $a1,$a1,4
	lw $t3,($a2)
	addi $a2,$a2,4
	sub $t2,$t2,$t1
	add $t2,$t2,$t3
	mul $t2,$t2,100
	div $t2,$t1
	mflo $t2
	sw $t2,($a3)
	addi $a3,$a3,4
	addi $t0,$t0,1
	bne $t0,DIM,loop
	jr $ra
.end rendimento