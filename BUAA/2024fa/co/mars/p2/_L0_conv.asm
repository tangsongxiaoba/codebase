.data
	arr0: .space 1000
	arr1: .space 1000
	space: .asciiz " "
	line: .asciiz "\n"

.macro scn
	li $v0, 5
	syscall
	sw $v0, 0($sp)
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
		la $s0, arr0
		la $s1, arr1
		scn
		lw $s2, 0($sp) # s2 -> m1
		scn
		lw $s3, 0($sp) # s3 -> n1
		scn
		lw $s4, 0($sp) # s4 -> m2
		scn
		lw $s5, 0($sp) # s5 -> n2
		move $t0, $0 # t0 -> i
		
		loop_i:
			slt $t7, $t0, $s2
			beq $t7, 0, loop_2_start
			move $t1, $0 # t1 -> j
			loop_j:
				slt $t7, $t1, $s3
				beq $t7, 0, loop_i_end
				# arr0[i][j] = s0 + (t0*s3+t1)*4
				mul $t3, $t0, $s3
				add $t3, $t3, $t1
				mul $t3, $t3, 4
				add $t3, $t3, $s0
				scn
				lw $t2, 0($sp)
				sw $t2, 0($t3)
				addi $t1, $t1, 1 #j++
				j loop_j
			loop_i_end:
				addi $t0, $t0, 1 #i++
				j loop_i
		
		loop_2_start:
			move $t0, $0 # t0 -> i
			j loop_2_i
		loop_2_i:
			slt $t7, $t0, $s4
			beq $t7, 0, for_start
			move $t1, $0 # t1 -> j
			loop_2_j:
				slt $t7, $t1, $s5
				beq $t7, 0, loop_2_i_end
				# arr1[i][j] = s1 + (t0*s5+t1)*4
				mul $t3, $t0, $s5
				add $t3, $t3, $t1
				mul $t3, $t3, 4
				add $t3, $t3, $s1
				scn
				lw $t2, 0($sp)
				sw $t2, 0($t3)
				addi $t1, $t1, 1 #j++
				j loop_2_j
			loop_2_i_end:
				addi $t0, $t0, 1 #i++
				j loop_2_i
		
		for_start:
			move $t0, $0
			move $t8, $s2
			move $t9, $s3
			sub $s2, $s2, $s4 # s2 = m1-m2+1
			addi $s2, $s2, 1
			sub $s3, $s3, $s5 # s3 = n1-n2+1
			addi $s3, $s3, 1
			j for_i
		for_i:
			slt $t7, $t0, $s2
			beq $t7, 0, exit
			move $t1, $0
			for_j:
				slt $t7, $t1, $s3
				beq $t7, 0, for_i_end
				move $t2, $0
				move $s7, $0 # sum s7
				for_k:
					slt $t7, $t2, $s4
					beq $t7, 0, for_j_end
					move $t3, $0
					for_l:
						slt $t7, $t3, $s5
						beq $t7, 0, for_k_end
						# arr0[i+k][j+l] = s0 + ((t0+t2)*t9+t1+t3)*4
						add $t4, $t0, $t2
						mul $t4, $t4, $t9
						add $t4, $t4, $t1
						add $t4, $t4, $t3
						mul $t4, $t4, 4
						add $t4, $t4, $s0
						lw $t4, 0($t4)
						# arr1[k][l] = s1 + (t2*s5+t3)*4
						mul $t5, $t2, $s5
						add $t5, $t5, $t3
						mul $t5, $t5, 4
						add $t5, $t5, $s1
						lw $t5, 0($t5)
						mul $t4, $t4, $t5
						add $s7, $s7, $t4
						addi $t3, $t3, 1
						j for_l
					for_k_end:
						addi $t2, $t2, 1
						j for_k
				for_j_end:
					move $a0, $s7
					prn
					prs
					addi $t1, $t1, 1
					j for_j
			for_i_end:
				prl
				addi $t0, $t0, 1
				j for_i
		exit:
			li $v0, 10
			syscall