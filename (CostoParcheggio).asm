.data
ora_in: .byte 12, 47
ora_out: .byte 18, 14
X: .byte 1
Y: .byte 40
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra, ($sp)
	
	la $a0, ora_in # indirizzo di ora_in
	la $a1, ora_out # indirizzo di ora_out
	lbu $a2, X
	lbu $a3, Y
	
	jal costoParcheggio
	move $a0,$v0
	li $v0,1
	syscall
	
	lw $ra, ($sp)
	addi $sp,$sp,4
	jr $ra

.end main

.globl costoParcheggio
.ent costoParcheggio
costoParcheggio:
	lb $t0,($a0), 		# hh inizio
	lb $t1,1($a0),	# mm inizio
	lb $t2,($a1)		# hh fine
	lb $t3,1($a1)		# mm fine
	
	mul $a0,$t0,60
	add $t1,$a0,$t1
	mul $a0,$t2,60
	add $t3,$a0,$t3
	
	subu $t0,$t3,$t1 #intervallo di tempo in minuti
	div $t0,$a3
	mfhi $t0				# resto della divisione
	mflo $t1				# n° di intervalli
	beq $t0,0,nosumm
	addi $t1,$t1,1
nosumm:
	mul $v0,$t1,$a2
	jr $ra
.end costoParcheggio