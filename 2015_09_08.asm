N=13
.data
vett_input: .half 0, 782, 975, 434, -434, -975, -782
				.half 0, 782, 975, 434, -434, -975
vett_output: .space 2 * N - 1
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,vett_input
	li $a1, N
	la $a2,vett_output
	jal interpola
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main

.globl interpola
.ent interpola
interpola:
	li $t0,0
loop:
	mul $t1,$t0,2
	add $t1,$t1,$a0
	lh $t1,($t1)
	#sh $t1,($a2)
	#addi $a2,$a2,2
	and $t1,$t0,1
	beq $t1,0,pari
	addi $t1,$t0,-1
	addi $t2,$t0,1
	add $t1,$t1,$a0
	add $t2,$t2,$a0
	lh $t1,($t1)
	lh $t2,($t2)
	add $t1,$t1,$t2
	div $t1,$t1,2
	sh $t1,($a2)
	addi $a2,$a2,2
	b continue
pari:
	add $t1,$t0,$a0
	lh $t1,($t1)
	sh $t1,($a2)
	addi $a2,$a2,2
continue:
	addi $t0,$t0,1
	bne $t0,$a1,loop
	jr $ra
.end interpola