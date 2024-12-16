add $28, $0, $0
add $29, $0, $0
add $30, $0, $0
add $31, $0, $0
ori $28, $28, 4
nop
nop
nop
lui $1, 65535
ori $1, $1, 43673
lui $2, 0
ori $2, $2, 30847
nop
nop
nop
add $26, $1, $2
nop
nop
nop
sw $26, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x305c
nop
ADDR_0x305c:
lui $4, 65535
ori $4, $4, 34268
lui $5, 65535
ori $5, $5, 33747
nop
nop
nop
add $0, $4, $5
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3098
nop
ADDR_0x3098:
lui $16, 65535
ori $16, $16, 55791
lui $17, 65535
ori $17, $17, 36301
nop
nop
nop
sub $27, $16, $17
nop
nop
nop
sw $27, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x30d4
nop
ADDR_0x30d4:
lui $2, 65535
ori $2, $2, 61742
nop
nop
nop
ori $19, $2, 61613
nop
nop
nop
sw $19, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3108
nop
ADDR_0x3108:
lui $26, 65535
ori $26, $26, 58039
nop
nop
nop
ori $0, $26, 54294
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x313c
nop
ADDR_0x313c:
lui $14, 65535
ori $14, $14, 58628
nop
nop
nop
ori $15, $0, 2141
nop
nop
nop
lb $14, -2117($15)
nop
nop
nop
sw $14, 0($29)
add $29, $29, $28
sw $15, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3188
nop
ADDR_0x3188:
lui $19, 65535
ori $19, $19, 53847
nop
nop
nop
ori $8, $0, 30066
sub $8, $0, $8
nop
nop
nop
lb $19, 30127($8)
nop
nop
nop
sw $19, 0($29)
add $29, $29, $28
sw $8, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x31d8
nop
ADDR_0x31d8:
lui $23, 65535
ori $23, $23, 33685
nop
nop
nop
ori $24, $0, 13769
sub $24, $0, $24
nop
nop
nop
lb $23, 13799($24)
nop
nop
nop
sw $23, 0($29)
add $29, $29, $28
sw $24, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3228
nop
ADDR_0x3228:
lui $12, 0
ori $12, $12, 5939
nop
nop
nop
ori $4, $0, 24393
nop
nop
nop
lb $12, -24326($4)
nop
nop
nop
sw $12, 0($29)
add $29, $29, $28
sw $4, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3274
nop
ADDR_0x3274:
lui $27, 65535
ori $27, $27, 39156
nop
nop
nop
ori $11, $0, 16440
sub $11, $0, $11
nop
nop
nop
lb $27, 16468($11)
nop
nop
nop
sw $27, 0($29)
add $29, $29, $28
sw $11, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x32c4
nop
ADDR_0x32c4:
lui $2, 0
ori $2, $2, 11817
nop
nop
nop
ori $21, $0, 22215
nop
nop
nop
lh $2, -22129($21)
nop
nop
nop
sw $2, 0($29)
add $29, $29, $28
sw $21, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3310
nop
ADDR_0x3310:
lui $22, 65535
ori $22, $22, 56190
nop
nop
nop
ori $5, $0, 713
sub $5, $0, $5
nop
nop
nop
sb $22, 757($5)
nop
nop
nop
sw $22, 0($29)
add $29, $29, $28
sw $5, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3360
nop
ADDR_0x3360:
lui $25, 0
ori $25, $25, 7084
nop
nop
nop
ori $17, $0, 27745
sub $17, $0, $17
nop
nop
nop
sb $25, 27866($17)
nop
nop
nop
sw $25, 0($29)
add $29, $29, $28
sw $17, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x33b0
nop
ADDR_0x33b0:
lui $7, 0
ori $7, $7, 8848
nop
nop
nop
ori $3, $0, 6465
nop
nop
nop
sb $7, -6299($3)
nop
nop
nop
sw $7, 0($29)
add $29, $29, $28
sw $3, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x33fc
nop
ADDR_0x33fc:
lui $17, 0
ori $17, $17, 3987
nop
nop
nop
ori $20, $0, 4826
nop
nop
nop
sb $17, -4659($20)
nop
nop
nop
sw $17, 0($29)
add $29, $29, $28
sw $20, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3448
nop
ADDR_0x3448:
lui $10, 0
ori $10, $10, 19636
nop
nop
nop
ori $13, $0, 3571
nop
nop
nop
sh $10, -3447($13)
nop
nop
nop
sw $10, 0($29)
add $29, $29, $28
sw $13, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3494
nop
ADDR_0x3494:
lui $9, 0
ori $9, $9, 25837
nop
nop
nop
ori $11, $0, 14172
nop
nop
nop
sh $9, -13970($11)
nop
nop
nop
sw $9, 0($29)
add $29, $29, $28
sw $11, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x34e0
nop
ADDR_0x34e0:
lui $5, 0
ori $5, $5, 10789
lui $22, 65535
ori $22, $22, 40437
nop
nop
nop
add $15, $5, $22
nop
nop
nop
sw $15, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x351c
nop
ADDR_0x351c:
lui $19, 0
ori $19, $19, 23218
lui $4, 0
ori $4, $4, 24548
nop
nop
nop
add $0, $19, $4
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3558
nop
ADDR_0x3558:
lui $3, 0
ori $3, $3, 1429
lui $18, 65535
ori $18, $18, 53764
nop
nop
nop
sub $2, $3, $18
nop
nop
nop
sw $2, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3594
nop
ADDR_0x3594:
lui $15, 0
ori $15, $15, 1998
lui $6, 0
ori $6, $6, 27785
nop
nop
nop
sub $0, $15, $6
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x35d0
nop
ADDR_0x35d0:
lui $21, 65535
ori $21, $21, 34421
lui $8, 65535
ori $8, $8, 43541
nop
nop
nop
andi $1, $8, 1
nop
nop
nop
sw $1, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x360c
nop
ADDR_0x360c:
lui $20, 65535
ori $20, $20, 35628
lui $10, 65535
ori $10, $10, 38187
nop
nop
nop
andi $0, $10, 28
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3648
nop
ADDR_0x3648:
lui $24, 65535
ori $24, $24, 50472
lui $27, 65535
ori $27, $27, 35390
nop
nop
nop
andi $3, $27, 25
nop
nop
nop
sw $3, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3684
nop
ADDR_0x3684:
lui $21, 0
ori $21, $21, 2882
lui $22, 0
ori $22, $22, 1622
nop
nop
nop
or $0, $21, $22
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x36c0
nop
ADDR_0x36c0:
lui $27, 0
ori $27, $27, 7300
lui $20, 0
ori $20, $20, 5714
nop
nop
nop
and $23, $27, $20
nop
nop
nop
sw $23, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x36fc
nop
ADDR_0x36fc:
lui $5, 65535
ori $5, $5, 37329
lui $7, 0
ori $7, $7, 5282
nop
nop
nop
and $0, $5, $7
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3738
nop
ADDR_0x3738:
lui $6, 0
ori $6, $6, 8597
lui $3, 0
ori $3, $3, 12804
nop
nop
nop
or $19, $6, $3
nop
nop
nop
sw $19, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3774
nop
ADDR_0x3774:
lui $21, 0
ori $21, $21, 15309
nop
nop
nop
addi $15, $21, -7609
nop
nop
nop
sw $15, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x37a8
nop
ADDR_0x37a8:
lui $1, 65535
ori $1, $1, 56490
nop
nop
nop
addi $0, $1, -7456
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x37dc
nop
ADDR_0x37dc:
lui $27, 65535
ori $27, $27, 58475
nop
nop
nop
andi $1, $27, 28717
nop
nop
nop
sw $1, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3810
nop
ADDR_0x3810:
lui $16, 65535
ori $16, $16, 41711
nop
nop
nop
andi $27, $16, 32925
nop
nop
nop
sw $27, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3844
nop
ADDR_0x3844:
lui $2, 65535
ori $2, $2, 40078
nop
nop
nop
andi $0, $2, 60378
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3878
nop
ADDR_0x3878:
lui $11, 0
ori $11, $11, 12838
nop
nop
nop
ori $1, $11, 18707
nop
nop
nop
sw $1, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x38ac
nop
ADDR_0x38ac:
lui $14, 0
ori $14, $14, 11445
lui $5, 65535
ori $5, $5, 45039
nop
nop
nop
slt $0, $14, $5
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x38e8
nop
ADDR_0x38e8:
lui $16, 65535
ori $16, $16, 37621
nop
nop
nop
slt $17, $16, $16
nop
nop
nop
sw $17, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x391c
nop
ADDR_0x391c:
lui $6, 65535
ori $6, $6, 39294
nop
nop
nop
sltu $15, $6, $15
nop
nop
nop
sw $15, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3950
nop
ADDR_0x3950:
lui $9, 65535
ori $9, $9, 38787
nop
nop
nop
sltu $3, $9, $0
nop
nop
nop
sw $3, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3984
nop
ADDR_0x3984:
lui $21, 0
ori $21, $21, 3194
nop
nop
nop
sltu $0, $21, $21
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x39b8
nop
ADDR_0x39b8:
lui $5, 65535
ori $5, $5, 58433
lui $14, 0
ori $14, $14, 6262
nop
nop
nop
sltu $21, $5, $14
nop
nop
nop
sw $21, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x39f4
nop
ADDR_0x39f4:
lui $13, 65535
ori $13, $13, 38891
lui $7, 0
ori $7, $7, 2779
nop
nop
nop
sltu $0, $13, $7
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3a30
nop
ADDR_0x3a30:
lui $9, 0
ori $9, $9, 4647
lui $24, 0
ori $24, $24, 28185
nop
nop
nop
bne $9, $24, ADDR_0x3a78
nop
ADDR_0x3a54:
nop
nop
nop
sw $9, 0($29)
add $29, $29, $28
sw $24, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3a90
nop
ADDR_0x3a78:
nop
nop
nop
nop
beq $0, $0, ADDR_0x3a54
nop
ADDR_0x3a90:
lui $11, 0
ori $11, $11, 4320
lui $11, 65535
ori $11, $11, 44887
nop
nop
nop
bne $11, $11, ADDR_0x3ad8
nop
ADDR_0x3ab4:
nop
nop
nop
sw $11, 0($29)
add $29, $29, $28
sw $11, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3af0
nop
ADDR_0x3ad8:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3ab4
nop
ADDR_0x3af0:
lui $27, 0
ori $27, $27, 23086
nop
nop
nop
beq $0, $27, ADDR_0x3b28
nop
ADDR_0x3b0c:
nop
nop
nop
sw $27, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3b40
nop
ADDR_0x3b28:
nop
nop
nop
nop
beq $0, $0, ADDR_0x3b0c
nop
ADDR_0x3b40:
lui $27, 65535
ori $27, $27, 39215
nop
nop
nop
beq $0, $27, ADDR_0x3b78
nop
ADDR_0x3b5c:
nop
nop
nop
sw $27, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3b90
nop
ADDR_0x3b78:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3b5c
nop
ADDR_0x3b90:
lui $0, 0
ori $0, $0, 32622
nop
nop
nop
beq $0, $0, ADDR_0x3bc8
nop
ADDR_0x3bac:
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3be0
nop
ADDR_0x3bc8:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3bac
nop
ADDR_0x3be0:
lui $20, 0
ori $20, $20, 19213
nop
nop
nop
bne $0, $20, ADDR_0x3c18
nop
ADDR_0x3bfc:
nop
nop
nop
sw $20, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3c30
nop
ADDR_0x3c18:
nop
nop
nop
nop
beq $0, $0, ADDR_0x3bfc
nop
ADDR_0x3c30:
lui $20, 65535
ori $20, $20, 39175
nop
nop
nop
bne $0, $20, ADDR_0x3c68
nop
ADDR_0x3c4c:
nop
nop
nop
sw $20, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3c80
nop
ADDR_0x3c68:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3c4c
nop
ADDR_0x3c80:
lui $0, 0
ori $0, $0, 24141
nop
nop
nop
bne $0, $0, ADDR_0x3cb8
nop
ADDR_0x3c9c:
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3cd0
nop
ADDR_0x3cb8:
nop
nop
nop
nop
beq $0, $0, ADDR_0x3c9c
nop
ADDR_0x3cd0:
lui $23, 0
ori $23, $23, 27610
nop
nop
nop
bne $0, $23, ADDR_0x3d08
nop
ADDR_0x3cec:
nop
nop
nop
sw $23, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3d20
nop
ADDR_0x3d08:
nop
nop
nop
nop
beq $0, $0, ADDR_0x3cec
nop
ADDR_0x3d20:
lui $23, 65535
ori $23, $23, 60265
nop
nop
nop
bne $0, $23, ADDR_0x3d58
nop
ADDR_0x3d3c:
nop
nop
nop
sw $23, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3d70
nop
ADDR_0x3d58:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3d3c
nop
ADDR_0x3d70:
lui $0, 0
ori $0, $0, 30794
nop
nop
nop
bne $0, $0, ADDR_0x3da8
nop
ADDR_0x3d8c:
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3dc0
nop
ADDR_0x3da8:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3d8c
nop
ADDR_0x3dc0:
lui $26, 0
ori $26, $26, 11385
nop
nop
nop
beq $0, $26, ADDR_0x3df8
nop
ADDR_0x3ddc:
nop
nop
nop
sw $26, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3e10
nop
ADDR_0x3df8:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3ddc
nop
ADDR_0x3e10:
lui $26, 65535
ori $26, $26, 62634
nop
nop
nop
beq $0, $26, ADDR_0x3e48
nop
ADDR_0x3e2c:
nop
nop
nop
sw $26, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3e60
nop
ADDR_0x3e48:
nop
nop
nop
nop
beq $0, $0, ADDR_0x3e2c
nop
ADDR_0x3e60:
lui $0, 0
ori $0, $0, 30629
nop
nop
nop
beq $0, $0, ADDR_0x3e98
nop
ADDR_0x3e7c:
nop
nop
nop
sw $0, 0($29)
add $29, $29, $28
beq $0, $0, ADDR_0x3eb0
nop
ADDR_0x3e98:
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3e7c
nop
ADDR_0x3eb0:
beq $0, $0, ADDR_0x3ed8
nop
ADDR_0x3eb8:
add $13, $0, $31
jr $13
nop
ADDR_0x3ec4:
nop
nop
nop
beq $0, $0, ADDR_0x3ef8
nop
ADDR_0x3ed8:
jal ADDR_0x3eb8
nop
nop
nop
nop
ori $30, $0, 8
beq $0, $0, ADDR_0x3ec4
nop
ADDR_0x3ef8:
lui $1, 9462
ori $1, $1, 50815
lui $27, 469
ori $27, $27, 54030
nop
nop
nop
mult $1, $27
nop
nop
nop
beq $0, $0, ADDR_0x3f2c
nop
ADDR_0x3f2c:
lui $15, 2237
ori $15, $15, 46798
lui $25, 57001
ori $25, $25, 35276
nop
nop
nop
multu $15, $25
nop
nop
nop
beq $0, $0, ADDR_0x3f60
nop
ADDR_0x3f60:
lui $2, 42276
ori $2, $2, 43995
lui $0, 34505
ori $0, $0, 37918
nop
nop
nop
mthi $2
nop
nop
nop
beq $0, $0, ADDR_0x3f94
nop
ADDR_0x3f94:
lui $10, 38704
ori $10, $10, 50507
lui $0, 24473
ori $0, $0, 49482
nop
nop
nop
mtlo $10
nop
nop
nop
beq $0, $0, ADDR_0x3fc8
nop
ADDR_0x3fc8:
beq $0, $0, ADDR_0x3fc8
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop