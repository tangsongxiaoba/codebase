ori $9, $0, 0
ori $10, $0, 10
ori $8, $0, 1
ori $12, $0, 0
ori $13, $0, 4
ori $4, $0, 0
ori $5, $0, 10
ADDR_0x301c:
beq $9, $10, ADDR_0x304c
nop
add $9, $9, $8
sw $12, 0($12)
add $12, $12, $13
jal ADDR_0x301c
nop
beq $4, $5, ADDR_0x3054
nop
add $4, $4, $8
sw $12, 0($12)
add $12, $12, $13
ADDR_0x304c:
jr $31
nop