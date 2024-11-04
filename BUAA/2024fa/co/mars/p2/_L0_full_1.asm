.data
	symbol: .space 100
	array: .space 100
	space: .asciiz " "
	line: .asciiz "\n"

.macro inc(%t0)
	addi %t0, %t0, 1
.end_macro

.macro scn(%t0)
	li $v0, 5
	syscall
	move %t0, $v0
.end_macro 

.macro prn(%num)
	add $a0, $0, %num
	li $v0, 1
	syscall
.end_macro

.macro prs(%str)
	.data 
		str: .asciiz %str
	.text
		la $a0, str
		li $v0, 4
		syscall
.end_macro 

.macro exit
	li $v0, 10
	syscall
.end_macro

.eqv n $s0
.eqv i $t0
.eqv id $a1
.eqv one $s1

.text
main:
	scn(n) # s0 -> n
	move id, $0 # a1 -> index
	li one, 1 # s1 -> 1
	jal f
	exit

f:
	bge id, n, if # index >= n: jump if
	move i, $0 # t0 -> i
	for:
		beq i, n, for_end # jump if i == n
		mul $t1, i, 4
		lw $t2, symbol($t1) # t2 == symbol[i]
		bne $t2, 0, if_end # jump if symbol[i] != 0
		add $t3, i, 1
		mul $t4, id, 4
		sw $t3, array($t4)
		sw one, symbol($t1)
		subi $sp, $sp, 16
		sw id, 4($sp) #index
		sw i, 8($sp) #i
		sw $t1, 12($sp)
		sw $ra, 16($sp)
		inc(id) # index + 1
		jal f
		lw id, 4($sp) #index
		lw i, 8($sp) #i
		lw $t1, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 16
		sw $0, symbol($t1)
		if_end:
			inc($t0)
			j for
	for_end:
		jr $ra

	if:
		move i, $0 # t0 -> i
		loop:
			beq i, n, loop_end # jump if i == n
			mul $t1, i, 4
			lw $t1, array($t1)
			prn($t1)
			prs(" ")
			inc(i)
			j loop
		loop_end:
			prs("\n")
			jr $ra
	
