ori $28, $0, 0
ori $29, $0, 0
ori $1, $0, 4112
lui $2, 34595
ori $3, $0, 30806
lui $4, 34303
ori $5, $0, 1
lui $6, 65535
ori $7, $0, 65535
add $1, $1, $2
add $9, $1, $3
sub $8, $1, $2
sub $0, $7, $0
beq $28, $17, ADDR_0x3044
nop
beq $0, $0, ADDR_0x3094
nop
ADDR_0x3044:
beq $1, $2, ADDR_0x3094
nop
ori $2, $0, 12
nop
nop
nop
jal ADDR_0x306c
sw $1, 0($2)
beq $0, $0, ADDR_0x3094
add $1, $1, $2
ADDR_0x306c:
add $1, $1, $2
add $1, $1, $2
add $1, $1, $2
sw $31, 0($2)
lw $1, 0($2)
nop
nop
nop
jr $1
sw $31, 0($2)
ADDR_0x3094:
beq $0, $0, ADDR_0x3094
nop