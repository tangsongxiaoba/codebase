ori $28, $0, 0
ori $29, $0, 0
ori $1, $0, 13398
add $1, $1, $1
lw $1, 4($0)
sw $1, 4($0)
lui $2, 30840
sub $3, $2, $1
lui $5, 4660
ori $4, $0, 5
nop
sw $5, -1($4)
lw $3, -1($4)
beq $3, $5, ADDR_0x3044
nop
beq $0, $0, ADDR_0x3084
nop
ADDR_0x3044:
ori $7, $3, 1028
beq $7, $3, ADDR_0x3084
nop
lui $8, 30583
ori $8, $8, 65535
sub $0, $0, $8
ori $0, $0, 4352
add $10, $7, $6
ori $8, $0, 0
ori $9, $0, 1
ori $10, $0, 1
ADDR_0x3070:
add $8, $8, $10
beq $8, $9, ADDR_0x3070
jal ADDR_0x3088
nop
add $10, $10, $10
ADDR_0x3084:
beq $0, $0, ADDR_0x3084
ADDR_0x3088:
add $10, $10, $10
jr $31
nop