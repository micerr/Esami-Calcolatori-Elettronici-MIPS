N=9
M=6
.data
tabella: .byte 'a','b','b','a','c','b','a','d','d', 0
			.byte 'a','b','b','c','c','d','b','a','d', 0
			.byte 'b','b','b','c','a','c','d','c','a', 0
			.byte 'a','b','b','c','d','b','a','d','d', 0
			.byte 'b','c','b','c','c','b','a','d','d', 0
			.byte 'a','c','b','a','c','b','a','d','c', 0 
res: .byte 'a','b','b','c','d','b','a','d','d'
stat: .space N+1
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,tabella
	la $a1,res
	la $a2,stat
	jal valutazione
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main
.globl valutazione
.ent valutazione
valutazione:
	li $t0,N
	addi $t0,$t0,1
	mul $t0,$t0,M
	li $t1,0
	li $t4,0
	li $t5,0
loop:
	lb $t2,($a0)
	addi $a0,$a0,1
	lb $t3,($a1)
	addi $a1,$a1,1
	addi $t4,$t4,1
	bne $t2,$t3,continua
	addi $t5,$t5,1
continua:
	bne $t4,N,salta
	li $t4,0
	li $t6,N
	sub $a1,$a1,$t6
	sb $t5,($a0)
	li $t5,0
	addi $a0,$a0,1
	addi $t1,$t1,1
salta:
	addi $t1,$t1,1
	bne $t1,$t0,loop
	
	sub $a0,$a0,$t0
	li $t0,0
loop1:
	li $t1,0
	li $t3,0
	loop2:
		mul $t2,$t1,N+1
		addi $t2,$t2,N
		add $t2,$t2,$a0
		lb $t2,($t2)
		bne $t2,$t0,salta1
		addi $t3,$t3,1
	salta1:
		addi $t1,$t1,1
		bne $t1,M,loop2
	sb $t3,($a2)
	addi $a2,$a2,1
	addi $t0,$t0,1
	bne $t0,N+1,loop1
	jr $ra
.end valutazione