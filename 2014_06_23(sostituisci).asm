.data
str_orig: .asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente"
str_sost: .asciiz "per me si va"
str_new: .space 200
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,str_orig
	la $a1,str_sost
	la $a2,str_new
	jal sostituisci
	move $a0,$a2
	li $v0,4
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl sostituisci
.ent sostituisci
sostituisci:
	move $s1,$a2
loop:
	lbu $t0,($a0)
	addi $a0,$a0,1
	beq $t0,$0,fine
	bne $t0,'%',copy
	move $s0,$a1
	loop1:
		lbu $t1,($s0)
		addi $s0,$s0,1
		beq $t1,$0,continua
		sb $t1,($a2)
		addi $a2,$a2,1
		j loop1
copy:
	sb $t0,($a2)
	addi $a2,$a2,1
continua:
	j loop
fine:
	sb $0,($a2)
	addi $a2,$a2,1
	move $a2,$s1
	jr $ra
.end sostituisci