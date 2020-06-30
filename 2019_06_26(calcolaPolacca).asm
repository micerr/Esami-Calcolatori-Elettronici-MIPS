.data
espressione: .word 18, 25, 10, 7, -2, -3, -1, 13, -2
tabella: .word somma, sottrazione, moltiplicazione, divisione
.text
.globl main
.ent main
main: subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, espressione
	li $a1, 9
	jal calcolaPolaccaInversa
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra, ($sp)
	addu $sp, $sp, 4
	jr $ra
.end main
eseguiOperazione:
	subu $t0, $zero, $a0
	subu $t0, $t0, 1
	sll $t0, $t0, 2
	lw $t1, tabella($t0)
	jr $t1
somma: addu $v0, $a1, $a2
	b fine
sottrazione: subu $v0, $a1, $a2
	b fine
moltiplicazione: mulou $v0, $a1, $a2
	b fine
divisione: divu $v0, $a1, $a2
	b fine
fine: jr $ra
.globl calcolaPolaccaInversa
.ent calcolaPolaccaInversa
calcolaPolaccaInversa:
	addi $sp,$sp,-4
	sw $ra,($sp)
	add $t0,$0,$0
loop:
	lw $t1,($a0)
	addi $a0,$a0,4
	bge $t1,$0,operando
	addi $sp,$sp,-16
	sw $a0,($sp)
	sw $a1,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	move $a0,$t1
	lw $a1,20($sp)
	lw $a2,16($sp)
	jal eseguiOperazione
	lw $t1,12($sp)
	lw $t0, 8($sp)
	lw $a1,4($sp)
	lw $a0,($sp)
	addi $sp,$sp,24
	addi $sp,$sp,-4
	sw $v0,($sp)
	b continua
operando:
	addi $sp,$sp,-4
	sw $t1,($sp)
continua:
	addi $t0,$t0,1
	bne $t0,$a1,loop
	lw $v0,($sp)
	addi $sp,$sp,4
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end calcolaPolaccaInversa