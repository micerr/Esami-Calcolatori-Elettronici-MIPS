
	######### NON SI USANO I DOUBLE MA APPROSSIMO TUTTO IN INTEGER ######

DIM=7
.data
vet: .word 3, 5, 6, 0, 9, 8, 3
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,vet
	jal calcola
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl calcola
.ent calcola

## UTILIZZO FORMULA : 1/2( Sommatoria: i da 0 a n0 di ( B(i) + B(i+1) ) )

calcola:
	li $v0,0
	li $t0,0
	lw $s0,($a0) # primo
	li $s1,0 #ultimo
	li $s2,0 #somma
loop:
	lw $s1,($a0)
	addi $a0,$a0,4
	add $s2,$s2,$s1
	addi $t0,$t0,1
	bne $t0,DIM,loop
	sub $s0,$s2,$s0
	sub $s1,$s2,$s1
	add $s0,$s0,$s1
	div $v0,$s0,2
	jr $ra
.end calcola