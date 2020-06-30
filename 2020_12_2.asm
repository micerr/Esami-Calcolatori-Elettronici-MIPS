.data
vettore: .byte 14, 16, 18, 134, 24, 22, 23, 149, 140, 141, 145, 146
vettoreCompresso: .space 12
INTERVALLO_QUANT = 10

 .text
 .globl main
 .ent main
main:
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, vettore
	li $a1, 12
	la $a2, vettoreCompresso
	jal comprimi

	lw $ra, ($sp)
	addu $sp, $sp, 4
	jr $ra
.end main
 
 .globl quantizza
 .ent quantizza
quantizza:
	divu $t0, $a0, INTERVALLO_QUANT
	mulou $v0, $t0, INTERVALLO_QUANT
	jr $ra
 .end quantizza
 
 .globl comprimi
 .ent comprimi
 comprimi:
	addi $sp,$sp,-4
	sw $ra,($sp)
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	li $s3,0
	li $s4,0
ciclo:
	lbu $a0,($s0)
	addi $s0,$s0,1
	addi $s3,$s3,1
	jal quantizza
	lbu $t0,($s2)
	bne $t0,$0,primo
	addi $s4,$s4,1
	sb $v0,($s2)
	move $t0,$v0
primo:
	beq $t0,$v0,salta
	addi $s4,$s4,1
	addi $s2,$s2,1
	sb $v0,($s2)
salta:
	bne $s3,$s1,ciclo
	move $v0,$s4
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
 .end comprimi