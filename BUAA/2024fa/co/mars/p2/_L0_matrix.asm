.data
	arr0: .space 400
	arr1: .space 400
	space: .asciiz " "
	line: .asciiz "\n"

.macro scan_num
	li $v0, 5
	syscall
	sw $v0, 0($sp)
.end_macro 

.macro print_num
	li $v0, 1
	syscall
.end_macro

.macro print_space
	la $a0, space
	li $v0, 4
	syscall
.end_macro

.macro println
	la $a0, line
	li $v0, 4
	syscall
.end_macro

.text
	main:
		scan_num
		lw $s0, 0($sp) # s0 -> n
		move $t0, $0 # t0 -> i
		la $s1, arr0 # s1 -> arr0
		move $t6, $s1
	
	loop_i:
		slt $t7, $t0, $s0
		beq $t7, 0, for_i_start
		move $t1, $0 # t1 -> j
		
		loop_j: 
			slt $t7, $t1, $s0
			beq $t7, 0, loop_i_end
			scan_num
			lw $t2, 0($sp)
			sw $t2, 0($t6)
			addi $t6, $t6, 4
			addi $t1, $t1, 1 # j++
			j loop_j
			
		loop_i_end:
			addi $t0, $t0, 1 # i++
			j loop_i	
	
	for_i_start:
		move $t0, $0
		la $s1, arr1 # s1 -> arr1
		move $t6, $s1
		j for_i

	for_i:
		slt $t7, $t0, $s0
		beq $t7, 0, looop_i_start
		move $t1, $0 # t1 -> j
		
		for_j: 
			slt $t7, $t1, $s0
			beq $t7, 0, for_i_end
			scan_num
			lw $t2, 0($sp)
			sw $t2, 0($t6)
			addi $t6, $t6, 4
			addi $t1, $t1, 1 # j++
			j for_j
			
		for_i_end:
			addi $t0, $t0, 1 # i++
			j for_i	
			
	looop_i_start:
		move $t0, $0 # t0 -> i
		la $s1, arr0
		la $s2, arr1
		j looop_i
	
	looop_i:
		slt $t7, $t0, $s0
		beq $t7, 0, exit
		move $t1, $0 # t1 -> j
		
		looop_j:
			slt $t7, $t1, $s0
			beq $t7, 0, looop_i_end
			move $t2, $0 # t2 -> k
			move $s7, $0 # s7 -> sum
			
			looop_k:
				slt $t7, $t2, $s0
				beq $t7, 0, looop_j_end
				#t5 -> arr0[i][k] -> s1 + (t0*s0+t2)*4
				mul $t4, $t0, $s0
				add $t4, $t4, $t2
				mul $t4, $t4, 4
				add $t5, $s1, $t4
				lw $t5, 0($t5)
				#t6 -> arr1[k][j] -> s2 + (t2*s0+t1)*4
				mul $t4, $t2, $s0
				add $t4, $t4, $t1
				mul $t4, $t4, 4
				add $t6, $s2, $t4
				lw $t6, 0($t6)
				mul $s6, $t5, $t6
				add $s7, $s7, $s6
				addi $t2, $t2, 1 # k++
				j looop_k
			
			looop_j_end:
				move $a0, $s7
				print_num
				print_space
				addi $t1, $t1, 1 # j++
				j looop_j
		
		looop_i_end:
			println
			addi $t0, $t0, 1 # i++
			j looop_i
				
	exit:
		li $v0, 10
		syscall
				
		
		
		