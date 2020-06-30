NUM=3
MINUTIGIORNO=60*24
WNUM=NUM*4
.data
tempi: .byte 8, 27, 17, 12, 21, 34, 9, 41, 7, 18, 15, 5
risultato: .space NUM*4
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,tempi
	la $a1,risultato
	jal calcolaDifferenza
	li $t0,0
loop:
	lw $a0,risultato($t0)
	li $v0,1
	syscall
	addi $t0,$t0,4
	bne $t0,WNUM,loop
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl calcolaDifferenza
.ent calcolaDifferenza
calcolaDifferenza:
	li $t0,0
loop1:
	lbu $t1,($a0) 	# ore
	addi $a0,$a0,1
	mul $t1,$t1,60
	lbu $t2,($a0)		# minuti
	addi $a0,$a0,1
	add $t1,$t1,$t2 # t1 minuti primo orario
	lbu $t2,($a0)		#ore
	addi $a0,$a0,1
	mul $t2,$t2,60
	lbu $t3,($a0)		#minuti
	addi $a0,$a0,1
	add $t2,$t2,$t3	#t2 minuti secondo orario
	bge $t2,$t1,semplice
	addi $t2,$t2,MINUTIGIORNO
semplice:
	sub $t1,$t2,$t1
	sw $t1,($a1)
	addi $a1,$a1,4
	addi $t0,$t0,1
	bne $t0,NUM,loop1
	jr $ra
.end calcolaDifferenza