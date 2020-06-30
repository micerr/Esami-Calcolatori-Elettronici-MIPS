DIM = 5
.data
vet1: .word 56, 12, 98, 129, 58
vet2: .word 1, 0, 245, 129, 12
risultato: .space DIM
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0, vet1
	la $a1, vet2
	la $a2, risultato
	li $a3, DIM
	jal CalcolaDistanzaH
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl CalcolaDistanzaH
.ent CalcolaDistanzaH
CalcolaDistanzaH:
	li $t0,0
loop:
	lw $t1,($a0)
	lw $t2,($a1)
	addi $a0,$a0,4
	addi $a1,$a1,4
	li $t3,0
	li $t6,0
	loop2:
		and $t4,$t1,1
		and $t5,$t2,1
		beq $t4,$t5,salta
		addi $t6,$t6,1
	salta:
		srl $t1,$t1,1
		srl $t2,$t2,1
		addi $t3,$t3,1
		bne $t3,32,loop2
	sb $t6,($a2)
	addi $a2,$a2,1
	addi $t0,$t0,1
	bne $t0,$a3,loop
	jr $ra
.end CalcolaDistanzaH