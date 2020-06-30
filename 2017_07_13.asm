NRIGHE=4
NCOLONNE=6
.data
matrice:  	.byte 0, 0, 0, 0, 0, 0
				.byte 0, 1, 0, 0, 0, 0
				.byte 0, 1, 1, 1, 1, 1
				.byte 0, 0, 0, 0, 0, 0 
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,matrice
	li $a1,1
	li $a2,0
	jal seguiPercorso
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl seguiPercorso
.ent seguiPercorso
seguiPercorso:
	li $v0,0
	mul $t0,$a1,NCOLONNE # riga
	add $t0,$t0,$a2 #colonna
	add $t0,$t0,$a0 #sommo con offset
	lb $t0,($t0)
	bne $t0,1,fine
	addi $v0,$v0,1
loop:
	mul $t0,$a1,NCOLONNE # riga
	add $t0,$t0,$a2 #colonna
	add $t0,$t0,$a0 #sommo con offset
	addi $t1,$t0,1 # destra
	lb $t1,($t1) #prendo destra
	bne $t1,1,salta
	add $v0,$v0,1
	add $a2,$a2,1
	b avanti
salta:
	addi $t1,$t0,NCOLONNE #giu
	lb $t1,($t1) #prendo giu
	bne $t1,1,fine
	add $v0,$v0,1
	addi $a1,$a1,1
avanti:
	beq $a1,NRIGHE,fine
	beq $a2,NCOLONNE,fine
	b loop
fine:
	jr $ra
.end seguiPercorso