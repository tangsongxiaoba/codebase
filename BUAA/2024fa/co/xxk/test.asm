ori $24, $0, 0x599
ori $27, $0, 0x7ed8
sh $24, 70($27)
mtlo $27
mflo $27
lui $6, 0x7fff
ori $6, $6, 0xfffe
lui $18, 0xffff
ori $18, $18, 0xfffe
jal label5
sub $22, $6, $18
label5:
mflo $6
ori $30, $0, 0x7ede
multu $30, $1
jal label13
lb $1, 66($30)
label13:
mflo $30
multu $4, $21
abs.d $f1, $f2
mfhi $4
mflo $28
ori $21, $0, 0x5c7e
lui $3, 0x7fff
ori $3, $3, 0xfffa
ori $4, $0, 0x1
add $21, $3, $4
mflo $3
multu $1, $19
jal label29
add.d $f1, $f2, $f3
label29:
mtlo $1
mfhi $1
mflo $9
ori $19, $0, 0xe21
ori $16, $0, 0x7ec5
lh $27, 75($16)
mtlo $16
mflo $16
lui $23, 0xffff
ori $23, $23, 0x8003
lui $13, 0xffff
ori $13, $13, 0x8004
jal label41
add $24, $23, $13
label41:
mtlo $23
mflo $23
beq $0, $0, ToJal50
nop
ToJr50:
sw $31, 8576($0)
ori $31, $0, 0xdf6
multu $31, $31
jr $31
mtlo $31
ToJal50:
jal ToJr50
mflo $1
mflo $2
jal label62
add.d $f1, $f2, $f3
label62:
mfhi $3
mflo $27
ori $5, $0, 0xe919
beq $0, $0, ToJal68
nop
ToJr68:
sw $31, 8576($0)
ori $31, $0, 0x2a0a
jr $31
mtlo $31
ToJal68:
jal ToJr68
mflo $1
mflo $2
ori $7, $0, 0x78f8
ori $26, $0, 0x7ecd
multu $26, $7
sb $7, 52($26)
mtlo $26
mflo $26
lui $21, 0x7fff
ori $21, $21, 0xff9e
multu $21, $2
lb $2, 99($21)
mtlo $21
mflo $21
ori $27, $0, 0x7ead
multu $27, $20
jal label91
lw $20, 99($27)
label91:
mtlo $27
mflo $27
ori $28, $0, 0x94a8
ori $7, $0, 0x7e9f
multu $7, $28
sw $28, 94($7)
mflo $7
beq $0, $0, ToJal103
nop
ToJr103:
sw $31, 8576($0)
ori $31, $0, 0xe2d5
jr $31
mtlo $31
ToJal103:
jal ToJr103
mflo $1
mflo $2
lui $19, 0x8000
ori $19, $19, 0x3
addi $29, $19, 13
mtlo $19
mflo $19
add.d $f1, $f2, $f3
mfhi $24
mflo $25
ori $16, $0, 0xb9a2
ori $7, $0, 0x7edc
lw $15, 68($7)
mtlo $7
mflo $7
ori $16, $0, 0x37da
lui $18, 0xffff
ori $18, $18, 0xffba
jal label127
sh $16, 74($18)
label127:
mtlo $18
mflo $18
lui $11, 0xfeda
ori $11, $11, 0xbba5
lui $9, 0x10ba
ori $9, $9, 0x2c52
jal label135
add $30, $11, $9
label135:
mtlo $11
mflo $11
ori $18, $0, 0x7ec5
jal label144
lh $9, 75($18)
label144:
mflo $18
beq $0, $0, ToJal149
nop
ToJr149:
sw $31, 8576($0)
ori $31, $0, 0x2afe
jr $31
mtlo $31
ToJal149:
jal ToJr149
mflo $1
mflo $2
beq $0, $0, ToJal160
nop
ToJr160:
addi $31, $31, 0
multu $31, $31
jr $31
mtlo $31
ToJal160:
jal ToJr160
mflo $1
mflo $2
beq $0, $0, ToJal171
nop
ToJr171:
addi $31, $31, -1
multu $31, $31
jr $31
mtlo $31
ToJal171:
jal ToJr171
mflo $1
mflo $2
beq $0, $0, ToJal182
nop
ToJr182:
multu $31, $31
jr $31
mtlo $31
ToJal182:
jal ToJr182
mflo $1
mflo $2
beq $0, $0, ToJal192
nop
ToJr192:
sw $31, 8576($0)
ori $31, $0, 0xab6d
jr $31
mtlo $31
ToJal192:
jal ToJr192
mflo $1
mflo $2
lui $1, 0x18e8
ori $1, $1, 0xa6f2
lui $26, 0x15c4
ori $26, $26, 0xd5a5
multu $1, $26
sub $25, $1, $26
mtlo $1
mflo $1
beq $0, $0, ToJal211
nop
ToJr211:
sw $31, 8576($0)
ori $31, $0, 0xa771
multu $31, $31
jr $31
mtlo $31
ToJal211:
jal ToJr211
mflo $1
mflo $2
beq $0, $0, ToJal223
nop
ToJr223:
sw $31, 8576($0)
ori $31, $0, 0x22e6
multu $31, $31
jr $31
mtlo $31
ToJal223:
jal ToJr223
mflo $1
mflo $2
lui $25, 0x8000
ori $25, $25, 0x4
multu $25, $14
jal label235
addi $14, $25, 14
label235:
mflo $25
ori $29, $0, 0x7ea9
multu $29, $16
lh $16, 99($29)
mtlo $29
mflo $29
ori $4, $0, 0x2fc2
multu $4, $23
jal label247
lw $23, 70($4)
label247:
mflo $4
ori $4, $0, 0x2fbe
jal label253
lw $14, 62($4)
label253:
mflo $4
ori $8, $0, 0xd578
ori $21, $0, 0x7e9c
jal label258
sb $8, 96($21)
label258:
mtlo $21
mflo $21
beq $0, $0, ToJal265
nop
ToJr265:
multu $31, $31
jr $31
mtlo $31
ToJal265:
jal ToJr265
mflo $1
mflo $2
lui $13, 0x7fff
ori $13, $13, 0xfffc
jal label275
addi $21, $13, 17
label275:
mtlo $13
mflo $13
lui $15, 0x7fff
ori $15, $15, 0xfffb
multu $15, $25
jal label282
addi $25, $15, 14
label282:
mtlo $15
mflo $15
ori $9, $0, 0xf5ea
ori $2, $0, 0x7ec9
sh $9, 87($2)
mtlo $2
mflo $2
lui $30, 0x8000
ori $30, $30, 0x3
jal label295
addi $9, $30, 13
label295:
mtlo $30
mflo $30
ori $22, $0, 0x7ffc
lui $29, 0xffff
ori $29, $29, 0x8002
jal label302
add $9, $22, $29
label302:
mtlo $22
mflo $22
lui $18, 0x7fff
ori $18, $18, 0xffb9
multu $18, $6
jal label310
lh $6, 71($18)
label310:
mflo $18
beq $0, $0, ToJal317
nop
ToJr317:
jr $31
mtlo $31
ToJal317:
jal ToJr317
mflo $1
mflo $2
beq $0, $0, ToJal326
nop
ToJr326:
addi $31, $31, -2
jr $31
mtlo $31
ToJal326:
jal ToJr326
mflo $1
mflo $2
beq $0, $0, ToJal336
nop
ToJr336:
sw $31, 8576($0)
ori $31, $0, 0xfc9
multu $31, $31
jr $31
mtlo $31
ToJal336:
jal ToJr336
mflo $1
mflo $2
multu $23, $11
jal label348
abs.s $f1, $f2
label348:
mfhi $23
mflo $27
ori $11, $0, 0xed2a
beq $0, $0, ToJal355
nop
ToJr355:
jr $31
mtlo $31
ToJal355:
jal ToJr355
mflo $1
mflo $2
ori $22, $0, 0x7ecb
multu $22, $1
jal label364
lh $1, 55($22)
label364:
mtlo $22
mflo $22
jal label371
abs.d $f1, $f2
label371:
mfhi $16
mflo $17
ori $4, $0, 0xde34
lui $11, 0x2fc1
ori $11, $11, 0x86b3
lui $18, 0xb213
ori $18, $18, 0x2768
add $22, $11, $18
mflo $11
ori $10, $0, 0x1203
multu $10, $1
lb $1, 98($10)
mtlo $10
mflo $10
add.d $f1, $f2, $f3
mtlo $7
mfhi $7
mflo $27
ori $3, $0, 0x6e50
ori $5, $0, 0x2408
ori $8, $0, 0x7eb4
sw $5, 72($8)
mtlo $8
mflo $8
lui $20, 0x7fff
ori $20, $20, 0xffcb
jal label398
lh $5, 53($20)
label398:
mflo $20
multu $17, $26
mov.s $f1, $f2
mfhi $17
mflo $14
ori $26, $0, 0x902d
beq $0, $0, ToJal409
nop
ToJr409:
sw $31, 8576($0)
ori $31, $0, 0x15a3
jr $31
mtlo $31
ToJal409:
jal ToJr409
mflo $1
mflo $2
multu $23, $27
jal label420
add.d $f1, $f2, $f3
label420:
mtlo $23
mfhi $23
mflo $5
ori $27, $0, 0xdc3b
ori $11, $0, 0x9548
ori $12, $0, 0x7ecd
jal label428
sh $11, 65($12)
label428:
mtlo $12
mflo $12
lui $19, 0x7fff
ori $19, $19, 0xfffe
addi $19, $19, 15
mflo $19
lui $22, 0x37f2
ori $22, $22, 0xd5d5
lui $12, 0xd718
ori $12, $12, 0x5cf9
jal label439
sub $26, $22, $12
label439:
mtlo $22
mflo $22
beq $0, $0, ToJal448
nop
ToJr448:
addi $31, $31, -3
jr $31
mtlo $31
ToJal448:
jal ToJr448
mflo $1
mflo $2
ori $25, $0, 0x33ba
ori $15, $0, 0x7ee7
sw $25, 57($15)
mtlo $15
mflo $15
ori $12, $0, 0x7ebe
jal label463
lb $7, 82($12)
label463:
mtlo $12
mflo $12
lui $29, 0x7fff
ori $29, $29, 0xfffd
ori $27, $0, 0x0
multu $29, $27
add $10, $29, $27
mtlo $29
mflo $29
beq $0, $0, ToJal476
nop
ToJr476:
sw $31, 8576($0)
ori $31, $0, 0x97d5
multu $31, $31
jr $31
mtlo $31
ToJal476:
jal ToJr476
mflo $1
mflo $2
ori $25, $0, 0x7ecb
multu $25, $30
jal label488
lh $30, 57($25)
label488:
mtlo $25
mflo $25
abs.d $f1, $f2
mfhi $0
mflo $30
ori $17, $0, 0x24b6
multu $27, $30
add.s $f1, $f2, $f3
mtlo $27
mfhi $27
mflo $1
ori $30, $0, 0xce01
multu $21, $16
mov.s $f1, $f2
mtlo $21
mfhi $21
mflo $5
ori $16, $0, 0x371
ori $30, $0, 0x1453
jal label511
lw $22, 69($30)
label511:
mflo $30
lui $7, 0x7fff
ori $7, $7, 0xfffc
addi $24, $7, 0
mtlo $7
mflo $7
beq $0, $0, ToJal521
nop
ToJr521:
addi $31, $31, -1
multu $31, $31
jr $31
mtlo $31
ToJal521:
jal ToJr521
mflo $1
mflo $2
ori $13, $0, 0x7eb8
jal label532
lb $5, 85($13)
label532:
mflo $13
ori $8, $0, 0x274a
ori $6, $0, 0x7ebc
multu $6, $8
sw $8, 80($6)
mflo $6
beq $0, $0, ToJal542
nop
ToJr542:
sw $31, 8576($0)
ori $31, $0, 0x2570
multu $31, $31
jr $31
mtlo $31
ToJal542:
jal ToJr542
mflo $1
mflo $2
lui $2, 0x7fff
ori $2, $2, 0xffa9
lb $10, 88($2)
mflo $2
lui $25, 0x7fff
ori $25, $25, 0xffb3
jal label558
lb $1, 77($25)
label558:
mtlo $25
mflo $25
mov.s $f1, $f2
mfhi $22
mflo $22
ori $26, $0, 0xa8fa
multu $3, $0
mov.d $f1, $f2
mfhi $3
mflo $29
ori $0, $0, 0xd211
beq $0, $0, ToJal574
nop
ToJr574:
jr $31
mtlo $31
ToJal574:
jal ToJr574
mflo $1
mflo $2
beq $0, $0, ToJal583
nop
ToJr583:
jr $31
mtlo $31
ToJal583:
jal ToJr583
mflo $1
mflo $2
ori $30, $0, 0x239d
multu $30, $12
jal label592
lh $12, 77($30)
label592:
mtlo $30
mflo $30
add.s $f1, $f2, $f3
mfhi $23
mflo $18
ori $24, $0, 0xde7a
beq $0, $0, ToJal603
nop
ToJr603:
sw $31, 8576($0)
ori $31, $0, 0xe8de
multu $31, $31
jr $31
mtlo $31
ToJal603:
jal ToJr603
mflo $1
mflo $2
ori $11, $0, 0x80e8
ori $26, $0, 0xbcc
jal label615
sb $11, 90($26)
label615:
mflo $26
lui $18, 0xffff
ori $18, $18, 0x8003
lui $27, 0xffff
ori $27, $27, 0x8000
multu $18, $27
jal label621
add $27, $18, $27
label621:
mtlo $18
mflo $18
ori $5, $0, 0xadaa
ori $26, $0, 0x7ec5
sh $5, 93($26)
mflo $26
ori $25, $0, 0x7ec7
multu $25, $15
lh $15, 73($25)
mflo $25
ori $25, $0, 0x4f4a
lui $9, 0x7fff
ori $9, $9, 0xffc1
multu $9, $25
sb $25, 63($9)
mtlo $9
mflo $9
ori $13, $0, 0x4258
ori $11, $0, 0x7ee1
multu $11, $13
jal label646
sb $13, 63($11)
label646:
mflo $11
beq $0, $0, ToJal653
nop
ToJr653:
multu $31, $31
jr $31
mtlo $31
ToJal653:
jal ToJr653
mflo $1
mflo $2
lui $11, 0xc342
ori $11, $11, 0xb115
lui $28, 0xb62a
ori $28, $28, 0x609a
sub $23, $11, $28
mflo $11
ori $1, $0, 0x603a
ori $27, $0, 0x7eb0
sw $1, 79($27)
mtlo $27
mflo $27
ori $8, $0, 0x7ebe
jal label674
lb $1, 82($8)
label674:
mflo $8
beq $0, $0, ToJal679
nop
ToJr679:
sw $31, 8576($0)
ori $31, $0, 0x294d
multu $31, $31
jr $31
mtlo $31
ToJal679:
jal ToJr679
mflo $1
mflo $2
multu $14, $28
abs.s $f1, $f2
mfhi $14
mflo $14
ori $28, $0, 0x13f2
ori $27, $0, 0x8368
lui $2, 0x7fff
ori $2, $2, 0xffc3
sh $27, 62($2)
mtlo $2
mflo $2
ori $25, $0, 0x2639
multu $25, $10
jal label702
lh $10, 79($25)
label702:
mtlo $25
mflo $25
beq $0, $0, ToJal709
nop
ToJr709:
sw $31, 8576($0)
ori $31, $0, 0x9b9
jr $31
mtlo $31
ToJal709:
jal ToJr709
mflo $1
mflo $2
beq $0, $0, ToJal720
nop
ToJr720:
addi $31, $31, 0
multu $31, $31
jr $31
mtlo $31
ToJal720:
jal ToJr720
mflo $1
mflo $2
lui $30, 0x7fff
ori $30, $30, 0xffb2
multu $30, $26
lh $26, 78($30)
mflo $30
lui $21, 0x7fff
ori $21, $21, 0xfffc
lui $10, 0xffff
ori $10, $10, 0xffff
jal label736
add $9, $21, $10
label736:
mflo $21
abs.d $f1, $f2
mtlo $14
mfhi $14
mflo $13
ori $4, $0, 0x291f
ori $17, $0, 0x6fd8
ori $13, $0, 0x7ed1
sh $17, 73($13)
mtlo $13
mflo $13
ori $17, $0, 0x7ec5
multu $17, $15
lb $15, 71($17)
mtlo $17
mflo $17
jal label759
mov.d $f1, $f2
label759:
mfhi $16
mflo $19
ori $5, $0, 0x9593
ori $18, $0, 0x6e48
ori $13, $0, 0xa67
jal label765
sw $18, 83($13)
label765:
mtlo $13
mflo $13
abs.d $f1, $f2
mfhi $8
mflo $9
ori $9, $0, 0x445f
beq $0, $0, ToJal776
nop
ToJr776:
sw $31, 8576($0)
ori $31, $0, 0x1241
multu $31, $31
jr $31
mtlo $31
ToJal776:
jal ToJr776
mflo $1
mflo $2
multu $21, $20
jal label788
add.d $f1, $f2, $f3
label788:
mtlo $21
mfhi $21
mflo $19
ori $20, $0, 0xfa95
ori $24, $0, 0x7ecd
multu $24, $16
lw $16, 57($24)
mflo $24
lui $1, 0x7fff
ori $1, $1, 0xffb5
multu $1, $17
jal label800
lh $17, 76($1)
label800:
mtlo $1
mflo $1
lui $16, 0x9f5d
ori $16, $16, 0xefc9
lui $9, 0xd789
ori $9, $9, 0x5a42
jal label808
sub $9, $16, $9
label808:
mtlo $16
mflo $16
lui $15, 0x7fff
ori $15, $15, 0xfffb
ori $28, $0, 0x3
jal label817
sub $11, $15, $28
label817:
mflo $15
lui $10, 0x43ff
ori $10, $10, 0xe1ec
lui $4, 0xc4a
ori $4, $4, 0xe0d
multu $10, $4
jal label824
sub $24, $10, $4
label824:
mtlo $10
mflo $10
lui $19, 0xd592
ori $19, $19, 0x7d87
lui $19, 0x214
ori $19, $19, 0x1916
jal label834
sub $22, $19, $19
label834:
mtlo $19
mflo $19
lui $3, 0xffff
ori $3, $3, 0xffb8
multu $3, $23
lb $23, 72($3)
mflo $3
ori $16, $0, 0x48fa
ori $24, $0, 0x7eb1
jal label848
sw $16, 91($24)
label848:
mflo $24
ori $30, $0, 0x7ea6
jal label854
lw $24, 98($30)
label854:
mflo $30
lui $18, 0x3816
ori $18, $18, 0x186f
lui $15, 0x9d18
ori $15, $15, 0x8493
jal label859
sub $24, $18, $15
label859:
mtlo $18
mflo $18
beq $0, $0, ToJal868
nop
ToJr868:
addi $31, $31, 0
jr $31
mtlo $31
ToJal868:
jal ToJr868
mflo $1
mflo $2
lui $12, 0xffff
ori $12, $12, 0xffb5
multu $12, $11
lb $11, 77($12)
mflo $12
lui $9, 0x33b8
ori $9, $9, 0x4e5e
lui $16, 0x39a3
ori $16, $16, 0xaade
add $3, $9, $16
mtlo $9
mflo $9
ori $13, $0, 0x7eb1
jal label890
lw $9, 95($13)
label890:
mflo $13
ori $22, $0, 0x7ec0
multu $22, $14
jal label895
lb $14, 96($22)
label895:
mtlo $22
mflo $22
ori $28, $0, 0x7ed1
lb $15, 63($28)
mtlo $28
mflo $28
ori $22, $0, 0x7ea8
multu $22, $10
jal label906
lb $10, 92($22)
label906:
mflo $22
beq $0, $0, ToJal912
nop
ToJr912:
sw $31, 8576($0)
ori $31, $0, 0xc9bb
multu $31, $31
jr $31
mtlo $31
ToJal912:
jal ToJr912
mflo $1
mflo $2
ori $12, $0, 0xa529
ori $5, $0, 0x7ee4
jal label924
sb $12, 64($5)
label924:
mflo $5
beq $0, $0, ToJal930
nop
ToJr930:
sw $31, 8576($0)
ori $31, $0, 0xddaa
jr $31
mtlo $31
ToJal930:
jal ToJr930
mflo $1
mflo $2
lui $15, 0x8000
ori $15, $15, 0x0
lui $1, 0xffff
ori $1, $1, 0xfffe
jal label941
add $11, $15, $1
label941:
mtlo $15
mflo $15
ori $24, $0, 0x7ee2
jal label950
lw $1, 71($24)
label950:
mtlo $24
mflo $24
beq $0, $0, ToJal956
nop
ToJr956:
sw $31, 8576($0)
ori $31, $0, 0xe8a1
jr $31
mtlo $31
ToJal956:
jal ToJr956
mflo $1
mflo $2
beq $0, $0, ToJal967
nop
ToJr967:
sw $31, 8576($0)
ori $31, $0, 0x9012
jr $31
mtlo $31
ToJal967:
jal ToJr967
mflo $1
mflo $2
lui $21, 0x2aa0
ori $21, $21, 0x2f9a
lui $9, 0xf0c1
ori $9, $9, 0xb0b4
multu $21, $9
sub $10, $21, $9
mflo $21
ori $30, $0, 0x7ec9
lw $22, 87($30)
mflo $30
lui $22, 0x7fff
ori $22, $22, 0xffb4
multu $22, $21
jal label988
lw $21, 76($22)
label988:
mflo $22
lui $15, 0x8a0
ori $15, $15, 0x65a3
lui $22, 0x873
ori $22, $22, 0x7b55
multu $15, $22
jal label995
add $30, $15, $22
label995:
mflo $15
end:
beq $0, $0, end
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