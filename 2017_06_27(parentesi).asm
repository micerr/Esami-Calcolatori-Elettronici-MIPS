DIM=10
.data
string: .ascii "(1+2*(5-3)"
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,string
	li $a1,DIM
	jal verificaParentesi
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl verificaParentesi
.ent verificaParentesi
verificaParentesi:
	li $t0,0
	li $t1,0
loop:
	lb $s0,($a0)
	addi $a0,$a0,1
	bne $s0,'(',else
	addi $t0,$t0,1
	addi $sp,$sp,-4
	sw $t1,($sp)
	b endloop
else:
	bne $s0,')',endloop
	addi $t0,$t0,-1
	bge $t0,$0,continue
	move $v0,$t1
	jr $ra
continue:
	addi $sp,$sp,4
endloop:
	addi $t1,$t1,1
	bne $t1,$a1,loop
	beq $t0,$0,fine
	lw $v0,($sp)
	addi $sp,$sp,4
	jr $ra
fine:
	move $v0,$a1
	jr $ra
.end verificaParentesi