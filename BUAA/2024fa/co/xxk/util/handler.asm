# 主要处理PC异常
_quick_handle:
    mfc0 $k0, $13
    andi $k0, $k0, 0x00fc

    # 没有srl指令，这一步骤判断异常是否为0x0004
    ori	$k1, $0, 0x0010
    beq	$k0, $k1, adel_handler_quick
    nop
    
    beq $0, $0, _entry
    nop

# 入口程序
_entry:	
    mfc0 $1, $13
    ori	$k0, $0, 0x1000
    sw $sp, -4($k0)
    
    addi $k0, $k0, -256
    add $sp, $0, $k0
    
    beq $0, $0,	_save_context
    nop

# PC错误
adel_handler_quick:
    mfc0 $k0, $14
    addi $k0, $k0, -0x3000
    lui $k1, 0xffff
    ori $k1,$k1,0xe000
    and $k0,$k0,$k1
    bne $k0,$0,adel_type_2
    nop
    mfc0 $k0, $14
    andi $k0,$k0,3
    bne $k0,$0,adel_type_1
    nop
    jal _entry
    nop
    
# PC未对齐
adel_type_1:
    mfc0 $k0, $14
    andi $k0, $k0, 0xfffc
    addi $k0, $k0, 4
    mtc0 $k0, $14
    eret
    ori $1, $0, 0x1234
    
# PC超出范围
adel_type_2:
    ori $k0, $0, 0x2180
    lw $k0, 0($k0)
    mtc0 $k0,$14
    nop
    eret
    ori $1, $0, 0x1234

# 判断异常中断类型
_main_handler:
    mfc0 $k0, $13
    andi $k0, $k0, 0x00fc
    
    ori	$k1, $0, 0x0000
    beq	$k0, $k1, int_handler
    nop
    ori	$k1, $0, 0x0010
    beq	$k0, $k1, adel_handler
    nop
    ori	$k1, $0, 0x0014
    beq	$k0, $k1, ades_handler
    nop
    ori	$k1, $0, 0x0028
    beq	$k0, $k1, ri_handler
    nop
    ori	$k1, $0, 0x0030
    beq	$k0, $k1, ov_handler
    nop
    ori $k1, $0, 0x0020
    beq $k0, $k1, syscall_handler
    nop

# 判断中断类型
int_handler:
    sw $ra, 0($sp)
    addi $sp, $sp, -16
    mfc0 $v0, $12
    sw $v0, 0($sp)
    mfc0 $v0, $13
    sw $v0, 4($sp)
        
    # check INT[3]
    lw $v0, 0($sp)
    lw $v1, 4($sp)
    and	$v0, $v1, $v0
    andi $v0, $v0, 0x800
    bne	$v0, $0, timer1_handler
    nop
    
    # check INT[2]
    lw	$v0, 0($sp)
    lw	$v1, 4($sp)
    and	$v0, $v1, $v0
    andi $v0, $v0, 0x400
    bne	$v0, $0, timer0_handler
    nop
    jal interrupt_handler
    nop

# 外部中断
interrupt_handler:
    lui $k0, 0xffff
    ori $k0, $k0, 0xffff
    addi $k1, $0, 0x2180
    lw $k1, 0($k1)
    addi $k0, $0, 0x7f20
    sb $0, 0($k0)
    jal _restore_context
    nop

# Timer0中断
timer0_handler:
    lui $k0, 0xffff
    addi $k1, $0, 0x2180
    lw $k1, 0($k1) 
    addi $k0, $0, 0x7f00
    sw $0, 0($k0)
    jal _restore_context
    nop

# Timer1中断
timer1_handler:
    lui $k0, 0xffff
    ori $k0, $k0, 0x1
    addi $k1, $0, 0x2180
    lw $k1, 0($k1)
    addi $k0, $0, 0x7f10
    sw $0, 0($k0)
    jal _restore_context
    nop

# 其他AdEL异常直接跳过
adel_handler:
    mfc0 $t0, $14
    mfc0 $k0, $13
    lui	$t2, 0x8000
    and	$t3, $k0, $t2
    addi $t0, $t0, 4
    bne	$t3, $t2, adel_nxt
    nop
    addi $t0, $t0, 4
    adel_nxt:
    mtc0 $t0, $14
    jal	_restore_context
    nop

# AdES异常直接跳过
ades_handler:
    mfc0 $t0, $14
    mfc0 $k0, $13
    lui	$t2, 0x8000
    and	$t3, $k0, $t2
    addi $t0, $t0, 4
    bne	$t3, $t2, ades_nxt
    nop
    addi $t0, $t0, 4
    ades_nxt:
    mtc0 $t0, $14
    jal	_restore_context
    nop

# 未知指令直接跳过
ri_handler:
    mfc0 $t0, $14
    mfc0 $k0, $13
    lui	$t2, 0x8000
    and	$t3, $k0, $t2
    addi $t0, $t0, 4
    bne	$t3, $t2, ri_nxt
    nop
    addi $t0, $t0, 4
    ri_nxt:
    mtc0 $t0, $14
    jal	_restore_context
    nop
    
# 算术溢出直接跳过
ov_handler:
    mfc0 $t0, $14
    mfc0 $k0, $13
    lui	$t2, 0x8000
    and	$t3, $k0, $t2
    addi $t0, $t0, 4
    bne	$t3, $t2, ov_nxt
    nop
    addi $t0, $t0, 4
    ov_nxt:
    mtc0 $t0, $14
    jal	_restore_context
    nop

# 处理一下syscall直接跳过
syscall_handler:
    mfc0 $t0, $14
    mfc0 $k0, $13
    lui	$t2, 0x8000
    and	$t3, $k0, $t2
    addi $t0, $t0, 4
    bne	$t3, $t2, syscall_nxt
    nop
    addi $t0, $t0, 4
    syscall_nxt:
    mtc0 $t0, $14
    jal	_restore_context
    nop

# 返回
_restore:
    eret
    ori $1, $0, 0x1234
    
# 保存上下文
_save_context:
    sw $2, 8($sp)    
    sw $3, 12($sp)    
    sw $4, 16($sp)    
    sw $5, 20($sp)    
    sw $6, 24($sp)    
    sw $7, 28($sp)    
    sw $8, 32($sp)    
    sw $9, 36($sp)    
    sw $10, 40($sp)   
    sw $11, 44($sp)    
    sw $12, 48($sp)   
    sw $13, 52($sp)    
    sw $14, 56($sp)   
    sw $15, 60($sp)    
    sw $16, 64($sp)   
    sw $17, 68($sp)    
    sw $18, 72($sp)   
    sw $19, 76($sp)    
    sw $20, 80($sp)   
    sw $21, 84($sp)    
    sw $22, 88($sp)   
    sw $23, 92($sp)    
    sw $24, 96($sp)   
    sw $25, 100($sp)   
    sw $28, 112($sp)   
    sw $29, 116($sp)   
    sw $30, 120($sp)   
    sw $31, 124($sp)
    mfhi $k0
    sw $k0, 128($sp)
    mflo $k0
    sw $k0, 132($sp)
    jal	_main_handler
    nop
    
# 恢复上下文
_restore_context:
    addi $sp, $0, 0x1000
    addi $sp, $sp, -256
    lw $2, 8($sp)   
    lw $3, 12($sp)   
    lw $4, 16($sp)   
    lw $5, 20($sp)   
    lw $6, 24($sp)   
    lw $7, 28($sp)   
    lw $8, 32($sp)   
    lw $9, 36($sp)   
    lw $10, 40($sp)    
    lw $11, 44($sp)   
    lw $12, 48($sp)    
    lw $13, 52($sp)   
    lw $14, 56($sp)    
    lw $15, 60($sp)   
    lw $16, 64($sp)    
    lw $17, 68($sp)   
    lw $18, 72($sp)    
    lw $19, 76($sp)   
    lw $20, 80($sp)    
    lw $21, 84($sp)   
    lw $22, 88($sp)    
    lw $23, 92($sp)   
    lw $24, 96($sp)    
    lw $25, 100($sp)    
    lw $28, 112($sp)   
    lw $30, 120($sp)   
    lw $31, 124($sp)   
    lw $k0, 128($sp)
    mthi $k0
    lw $k0, 132($sp)
    mtlo $k0
    lw $29, 116($sp)
    ori $1,$0,1
    beq $0, $0, _restore	
    nop