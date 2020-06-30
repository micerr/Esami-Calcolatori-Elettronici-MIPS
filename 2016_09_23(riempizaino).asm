N =9		# Num elementi
W=27	# Capacità Zaino
.data
valori: .byte 200, 225, 250, 150, 125, 125, 130, 120, 75
pesi: .byte 10,    12,    15,    9,    7,    6,    6,     6,    4
stati: .space N
.text
.globl main
.ent main
main:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,valori
	la $a1,pesi
	la $a2,stati
	jal riempiZaino
	move $a0,$v0
	li $v0,1
	syscall
	move $a0,$v1
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
.end main

.globl riempiZaino
.ent riempiZaino
riempiZaino:
	li $v0,0
	li $v1,0
loop:
	li $t0,0
	li $t1,0 # max
	li $s0,0 #pos max
	loop1:
		add $t2,$t0,$a2 # indirizzo stato
		lb $t2,($t2)
		bne $t2,0,salta
		add $t2,$t0,$a0 # indirizzo val
		add $t3,$t0,$a1 # indirizzo peso
		lbu $t2,($t2) # Ci
		lbu $t3,($t3) # Wi
		div $t2,$t3
		mflo $t2 # costo unitario
		ble $t2,$t1,salta
		move $t1,$t2
		move $s0,$t0
	salta:
		addi $t0,$t0,1
		bne $t0,N,loop1
	bne $t1,0,avanti
	li $s1,1
	b salta1
avanti:
	add $t0,$s0,$a1 # indirizzo peso oggetto individuato
	lb $t0,($t0) #peso oggetto individuato
	add $t1,$t0,$v1 #somma pesi
	bgt $t1,W,non_inserisco #perche supera il max
	add $v1,$v1,$t0
	add $t0,$s0,$a0
	lbu $t0,($t0)
	add $v0,$v0,$t0
	add $t0,$s0,$a2
	li $t1,1
	sb $t1,($t0)
	b salta1
non_inserisco:
	add $t0,$s0,$a2
	li $t1,-1
	sb $t1,($t0)
salta1:
	beq $s1,1,fine
	bne $v0,W,loop
fine:
	jr $ra
.end riempiZaino