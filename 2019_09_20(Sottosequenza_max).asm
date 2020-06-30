.data
vet: .word 15, 64, 9, 2, 4, 5, 9, 1, 294, 52, -4, 5
.text
.globl main
.ent main
main: 
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	la $a0, vet # indirizzo di vet
	li $a1, 12 # dimensione di vet
	jal monotono
	move $a0,$v0
	move $t1,$v1
	li $v0, 1
	syscall
	move $a0,$t1
	li $v0,1
	syscall
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
.end main
.globl monotono
.ent monotono
monotono:
	li $v1,0
	li $v0,0
	li $t0,1
	lw $t1,($a0)
	addi $a0,$a0,4
	li $t3,0
	li $t4,1
loop:
	lw $t2,($a0)
	addi $a0,$a0,4
	bge $t2,$t1,avanti
	ble $t4,$v1,nonsalva
	move $v0,$t4
	move $v1,$t3
nonsalva:
	move $t3,$t0
	li $t4,0
avanti:
	addi $t4,$t4,1
	move $t1,$t2
	addi $t0,$t0,1
	bne $t0,$a1,loop
	jr $ra
.end monotono