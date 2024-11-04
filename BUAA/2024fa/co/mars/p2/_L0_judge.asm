.data
	arr: .space 50
	space: .asciiz " "
	line: .asciiz "\n"

.macro scn
	li $v0, 5
	syscall
	sw $v0, 0($sp)
.end_macro 

.macro scc
	li $v0, 12
	syscall
.end_macro

.macro prn
	li $v0, 1
	syscall
.end_macro

.macro prs
	la $a0, space
	li $v0, 4
	syscall
.end_macro

.macro prl
	la $a0, line
	li $v0, 4
	syscall
.end_macro

.text
	main:
		scn
		lw $s0, 0($sp) # s0 -> n
		div $s3, $s0, 2 # s3 -> n // 2
		sub $s2, $s0, 1 # s2 -> n-1
		andi $t0, $s0, 1
		seq $t1, $t0, 1
		add $s3, $s3, $t1 # if odd, s3 += 1 
		move $t0, $0 # t0 -> i
		la $s1, arr # s1 -> arr
		move $s5, $0 # s5 -> flag
	loop:
		slt $t7, $t0, $s0 # i < n
		beq $t7, 0, exit
		scc
		move $t6, $v0
		slt $t7, $t0, $s3 # i < [n/2]
		beq $t7, 0, loop_else
		# front
		# t1 -> s1 + i
		add $t1, $s1, $t0
		sb $t6, 0($t1)
		j loop_end
		loop_else:
			beq $s5, 1, loop_end
			# latter
			sub $t1, $s2, $t0 
			add $t1, $s1, $t1 # t1 -> arr[n-1-i]
			lb $t5, 0($t1)
			sne $s5, $t5, $t6 # t1 vs t6
		loop_end:
			addi $t0, $t0, 1 # i += 1
			j loop
	exit:
		seq $a0, $s5, 0
		prn
		li $v0, 10
		syscall
			
			
			
		
		