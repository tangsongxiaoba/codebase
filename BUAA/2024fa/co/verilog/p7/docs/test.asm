beq $0, $0, ToJal0
nop
ToJr0:
addi $31, $31, -1
jr $31
mtlo $31
ToJal0:
jal ToJr0
mflo $1
mflo $2
lui $11, 0x7fff
ori $11, $11, 0xffcc
jal label10
lw $10, 52($11)
label10:
mtlo $11
mflo $11
beq $0, $0, ToJal17
nop
ToJr17:
sw $31, 8576($0)
ori $31, $0, 0xf53d
jr $31
mtlo $31
ToJal17:
jal ToJr17
mflo $1
mflo $2
multu $25, $3
mov.d $f1, $f2
mtlo $25
mfhi $25
mflo $26
ori $3, $0, 0x3ab0
ori $10, $0, 0x1e49
multu $10, $1
lw $1, 87($10)
mflo $10
ori $17, $0, 0x7eb8
multu $17, $2
jal label38
lb $2, 72($17)
label38:
mflo $17
ori $7, $0, 0xf6da
lui $8, 0x7fff
ori $8, $8, 0xffa9
multu $8, $7
sh $7, 88($8)
mflo $8
lui $8, 0xffff
ori $8, $8, 0x8003
ori $28, $0, 0x7ffb
jal label50
sub $8, $8, $28
label50:
mflo $8
beq $0, $0, ToJal57
nop
ToJr57:
addi $31, $31, -3
jr $31
mtlo $31
ToJal57:
jal ToJr57
mflo $1
mflo $2
lui $3, 0x8000
ori $3, $3, 0x2
ori $3, $0, 0x2
jal label67
add $2, $3, $3
label67:
mflo $3
lui $14, 0x8000
ori $14, $14, 0x0
multu $14, $8
addi $8, $14, 17
mflo $14
lui $10, 0xffff
ori $10, $10, 0x8000
ori $30, $0, 0x7ffd
multu $10, $30
sub $14, $10, $30
mflo $10
ori $30, $0, 0x7ec3
lb $12, 77($30)
mflo $30
lui $27, 0x8000
ori $27, $27, 0x3
multu $27, $16
addi $16, $27, 2
mtlo $27
mflo $27
multu $21, $18
jal label94
abs.s $f1, $f2
label94:
mfhi $21
mflo $27
ori $18, $0, 0x854f
lui $22, 0x8000
ori $22, $22, 0x4
ori $20, $0, 0x0
sub $6, $22, $20
mtlo $22
mflo $22
ori $6, $0, 0x7ffc
ori $11, $0, 0x7ffb
multu $6, $11
jal label107
add $24, $6, $11
label107:
mflo $6
beq $0, $0, ToJal114
nop
ToJr114:
sw $31, 8576($0)
ori $31, $0, 0x277
multu $31, $31
jr $31
mtlo $31
ToJal114:
jal ToJr114
mflo $1
mflo $2
lui $7, 0x8000
ori $7, $7, 0x1
multu $7, $7
jal label126
addi $7, $7, 17
label126:
mflo $7
beq $0, $0, ToJal133
nop
ToJr133:
addi $31, $31, 0
jr $31
mtlo $31
ToJal133:
jal ToJr133
mflo $1
mflo $2
ori $30, $0, 0x1bc6
jal label143
lw $29, 78($30)
label143:
mtlo $30
mflo $30
lui $3, 0x7fff
ori $3, $3, 0xff9d
jal label149
lb $15, 99($3)
label149:
mflo $3
ori $24, $0, 0x7eb9
multu $24, $28
jal label155
lw $28, 87($24)
label155:
mtlo $24
mflo $24
lui $21, 0xf68c
ori $21, $21, 0xdb67
lui $13, 0x187b
ori $13, $13, 0xe5e0
add $5, $21, $13
mflo $21
multu $6, $14
add.d $f1, $f2, $f3
mtlo $6
mfhi $6
mflo $13
ori $14, $0, 0xe235
beq $0, $0, ToJal174
nop
ToJr174:
addi $31, $31, -1
multu $31, $31
jr $31
mtlo $31
ToJal174:
jal ToJr174
mflo $1
mflo $2
lui $17, 0x7fff
ori $17, $17, 0xfffd
multu $17, $26
jal label185
addi $26, $17, 9
label185:
mflo $17
abs.d $f1, $f2
mtlo $24
mfhi $24
mflo $28
ori $16, $0, 0xd0d0
lui $5, 0xffff
ori $5, $5, 0xffa1
jal label197
lb $15, 93($5)
label197:
mtlo $5
mflo $5
ori $9, $0, 0x26c0
lw $7, 74($9)
mtlo $9
mflo $9
lui $22, 0x8000
ori $22, $22, 0x0
lui $19, 0xffff
ori $19, $19, 0xfffe
sub $24, $22, $19
mtlo $22
mflo $22
ori $30, $0, 0xb6e9
ori $22, $0, 0x7ec6
sw $30, 58($22)
mflo $22
ori $9, $0, 0x2e89
multu $9, $15
lw $15, 63($9)
mflo $9
lui $26, 0x8000
ori $26, $26, 0x2
lui $23, 0xffff
ori $23, $23, 0xfffd
multu $26, $23
jal label223
add $21, $26, $23
label223:
mtlo $26
mflo $26
lui $23, 0x8000
ori $23, $23, 0x2
multu $23, $29
addi $29, $23, 1
mtlo $23
mflo $23
multu $30, $19
mov.s $f1, $f2
mtlo $30
mfhi $30
mflo $26
ori $19, $0, 0x284
ori $14, $0, 0x172a
multu $14, $17
lw $17, 66($14)
mflo $14
jal label249
add.d $f1, $f2, $f3
label249:
mtlo $18
mfhi $18
mflo $2
ori $10, $0, 0xae4b
beq $0, $0, ToJal256
nop
ToJr256:
sw $31, 8576($0)
ori $31, $0, 0x2bb1
jr $31
mtlo $31
ToJal256:
jal ToJr256
mflo $1
mflo $2
lui $4, 0x7fff
ori $4, $4, 0xfffb
jal label267
addi $29, $4, 2
label267:
mtlo $4
mflo $4
lui $5, 0x68ba
ori $5, $5, 0x317c
lui $6, 0xf406
ori $6, $6, 0x805f
add $25, $5, $6
mflo $5
ori $1, $0, 0x7ea7
jal label280
lb $5, 91($1)
label280:
mflo $1
ori $25, $0, 0x6648
ori $21, $0, 0x7ebe
jal label285
sw $25, 62($21)
label285:
mflo $21
lui $15, 0x5875
ori $15, $15, 0x8396
lui $12, 0xf6f3
ori $12, $12, 0xe371
jal label291
sub $7, $15, $12
label291:
mtlo $15
mflo $15
ori $1, $0, 0x128a
lui $3, 0x7fff
ori $3, $3, 0xffbd
multu $3, $1
jal label300
sh $1, 67($3)
label300:
mflo $3
lui $13, 0x8000
ori $13, $13, 0x2
ori $19, $0, 0x3
jal label308
add $25, $13, $19
label308:
mflo $13
ori $16, $0, 0x7eeb
multu $16, $22
lw $22, 53($16)
mflo $16
ori $28, $0, 0xa068
lui $9, 0x7fff
ori $9, $9, 0xffb2
multu $9, $28
sw $28, 78($9)
mflo $9
ori $15, $0, 0x7e9c
lh $30, 98($15)
mflo $15
lui $16, 0x7fff
ori $16, $16, 0xfffe
ori $19, $0, 0x0
multu $16, $19
jal label328
sub $23, $16, $19
label328:
mtlo $16
mflo $16
beq $0, $0, ToJal337
nop
ToJr337:
addi $31, $31, 0
jr $31
mtlo $31
ToJal337:
jal ToJr337
mflo $1
mflo $2
beq $0, $0, ToJal347
nop
ToJr347:
sw $31, 8576($0)
ori $31, $0, 0x711e
jr $31
mtlo $31
ToJal347:
jal ToJr347
mflo $1
mflo $2
beq $0, $0, ToJal358
nop
ToJr358:
addi $31, $31, 2
jr $31
mtlo $31
ToJal358:
jal ToJr358
mflo $1
mflo $2
multu $27, $7
add.d $f1, $f2, $f3
mtlo $27
mfhi $27
mflo $19
ori $7, $0, 0xb665
beq $0, $0, ToJal374
nop
ToJr374:
addi $31, $31, -2
multu $31, $31
jr $31
mtlo $31
ToJal374:
jal ToJr374
mflo $1
mflo $2
lui $24, 0x7fff
ori $24, $24, 0xfffc
multu $24, $4
jal label385
addi $4, $24, 3
label385:
mflo $24
beq $0, $0, ToJal392
nop
ToJr392:
multu $31, $31
jr $31
mtlo $31
ToJal392:
jal ToJr392
mflo $1
mflo $2
beq $0, $0, ToJal402
nop
ToJr402:
addi $31, $31, -2
multu $31, $31
jr $31
mtlo $31
ToJal402:
jal ToJr402
mflo $1
mflo $2
ori $6, $0, 0x9f39
ori $29, $0, 0x7e9d
sb $6, 99($29)
mflo $29
beq $0, $0, ToJal417
nop
ToJr417:
sw $31, 8576($0)
ori $31, $0, 0xefcb
multu $31, $31
jr $31
mtlo $31
ToJal417:
jal ToJr417
mflo $1
mflo $2
beq $0, $0, ToJal429
nop
ToJr429:
addi $31, $31, 0
multu $31, $31
jr $31
mtlo $31
ToJal429:
jal ToJr429
mflo $1
mflo $2
add.s $f1, $f2, $f3
mtlo $5
mfhi $5
mflo $24
ori $23, $0, 0x88e9
lui $27, 0xbc4e
ori $27, $27, 0x918d
lui $5, 0xeb20
ori $5, $5, 0x48e0
jal label445
add $11, $27, $5
label445:
mflo $27
abs.d $f1, $f2
mtlo $23
mfhi $23
mflo $26
ori $4, $0, 0x2fb
lui $6, 0x7fff
ori $6, $6, 0xffcc
multu $6, $9
jal label458
lw $9, 52($6)
label458:
mflo $6
beq $0, $0, ToJal465
nop
ToJr465:
sw $31, 8576($0)
ori $31, $0, 0x9d8d
jr $31
mtlo $31
ToJal465:
jal ToJr465
mflo $1
mflo $2
ori $24, $0, 0x8b59
ori $10, $0, 0x7ee8
multu $10, $24
sh $24, 56($10)
mtlo $10
mflo $10
beq $0, $0, ToJal482
nop
ToJr482:
sw $31, 8576($0)
ori $31, $0, 0x29f
multu $31, $31
jr $31
mtlo $31
ToJal482:
jal ToJr482
mflo $1
mflo $2
beq $0, $0, ToJal494
nop
ToJr494:
jr $31
mtlo $31
ToJal494:
jal ToJr494
mflo $1
mflo $2
lui $29, 0x8000
ori $29, $29, 0x3
multu $29, $30
addi $30, $29, 3
mflo $29
lui $10, 0x4e4e
ori $10, $10, 0xbec5
lui $22, 0x1952
ori $22, $22, 0x2416
jal label508
sub $14, $10, $22
label508:
mtlo $10
mflo $10
lui $3, 0xfec1
ori $3, $3, 0x144
lui $30, 0xe1c6
ori $30, $30, 0x63ea
sub $6, $3, $30
mtlo $3
mflo $3
beq $0, $0, ToJal524
nop
ToJr524:
addi $31, $31, -2
jr $31
mtlo $31
ToJal524:
jal ToJr524
mflo $1
mflo $2
lui $20, 0x7fff
ori $20, $20, 0xfffc
multu $20, $22
jal label534
addi $22, $20, 6
label534:
mflo $20
lui $15, 0x7fff
ori $15, $15, 0xff9f
multu $15, $21
lb $21, 97($15)
mtlo $15
mflo $15
beq $0, $0, ToJal547
nop
ToJr547:
sw $31, 8576($0)
ori $31, $0, 0xe3a5
multu $31, $31
jr $31
mtlo $31
ToJal547:
jal ToJr547
mflo $1
mflo $2
ori $8, $0, 0x168a
multu $8, $8
lh $8, 70($8)
mflo $8
ori $26, $0, 0xf41a
lui $21, 0x7fff
ori $21, $21, 0xffc9
multu $21, $26
sw $26, 55($21)
mtlo $21
mflo $21
ori $27, $0, 0xa0b9
ori $29, $0, 0x2fb3
multu $29, $27
sb $27, 73($29)
mflo $29
ori $25, $0, 0x6bb9
ori $15, $0, 0x7edc
sw $25, 68($15)
mtlo $15
mflo $15
mov.s $f1, $f2
mfhi $4
mflo $13
ori $14, $0, 0xa268
beq $0, $0, ToJal584
nop
ToJr584:
addi $31, $31, 0
jr $31
mtlo $31
ToJal584:
jal ToJr584
mflo $1
mflo $2
lui $23, 0x7fff
ori $23, $23, 0xfffd
addi $8, $23, 19
mflo $23
ori $9, $0, 0x51f9
ori $29, $0, 0x2fc5
sh $9, 54($29)
mflo $29
ori $20, $0, 0x5a9
multu $20, $24
lb $24, 87($20)
mtlo $20
mflo $20
beq $0, $0, ToJal607
nop
ToJr607:
sw $31, 8576($0)
ori $31, $0, 0x5b
multu $31, $31
jr $31
mtlo $31
ToJal607:
jal ToJr607
mflo $1
mflo $2
abs.d $f1, $f2
mfhi $22
mflo $21
ori $4, $0, 0x986a
ori $12, $0, 0x18d8
lui $16, 0xffff
ori $16, $16, 0xffab
sh $12, 85($16)
mflo $16
lui $27, 0x7fff
ori $27, $27, 0xfffa
addi $23, $27, 3
mtlo $27
mflo $27
ori $18, $0, 0xeba9
ori $24, $0, 0x7ec3
sw $18, 89($24)
mflo $24
ori $1, $0, 0x68c8
ori $20, $0, 0x7ec4
jal label637
sw $1, 88($20)
label637:
mflo $20
lui $24, 0xffff
ori $24, $24, 0x8001
lui $30, 0xffff
ori $30, $30, 0x8002
sub $21, $24, $30
mtlo $24
mflo $24
add.s $f1, $f2, $f3
mtlo $6
mfhi $6
mflo $14
ori $28, $0, 0x9e
beq $0, $0, ToJal655
nop
ToJr655:
sw $31, 8576($0)
ori $31, $0, 0xe45
jr $31
mtlo $31
ToJal655:
jal ToJr655
mflo $1
mflo $2
lui $10, 0x1e2a
ori $10, $10, 0x8264
lui $8, 0xff58
ori $8, $8, 0x2534
multu $10, $8
jal label666
add $4, $10, $8
label666:
mtlo $10
mflo $10
beq $0, $0, ToJal676
nop
ToJr676:
sw $31, 8576($0)
ori $31, $0, 0x988
multu $31, $31
jr $31
mtlo $31
ToJal676:
jal ToJr676
mflo $1
mflo $2
jal label688
mov.d $f1, $f2
label688:
mfhi $28
mflo $7
ori $9, $0, 0x3e85
ori $6, $0, 0x7ede
multu $6, $7
jal label694
lw $7, 50($6)
label694:
mflo $6
beq $0, $0, ToJal700
nop
ToJr700:
multu $31, $31
jr $31
mtlo $31
ToJal700:
jal ToJr700
mflo $1
mflo $2
lui $21, 0x7fff
ori $21, $21, 0xffca
lh $1, 54($21)
mtlo $21
mflo $21
ori $19, $0, 0x7ec5
multu $19, $6
jal label715
lb $6, 59($19)
label715:
mflo $19
multu $6, $28
jal label721
mov.d $f1, $f2
label721:
mtlo $6
mfhi $6
mflo $13
ori $28, $0, 0x8889
multu $26, $16
jal label729
mov.s $f1, $f2
label729:
mfhi $26
mflo $21
ori $16, $0, 0x45eb
ori $29, $0, 0x1a5f
jal label736
lb $24, 77($29)
label736:
mtlo $29
mflo $29
beq $0, $0, ToJal742
nop
ToJr742:
addi $31, $31, 0
multu $31, $31
jr $31
mtlo $31
ToJal742:
jal ToJr742
mflo $1
mflo $2
multu $17, $1
jal label753
add.s $f1, $f2, $f3
label753:
mfhi $17
mflo $5
ori $1, $0, 0x3c18
ori $27, $0, 0x3b98
ori $21, $0, 0x2fb9
multu $21, $27
jal label760
sh $27, 75($21)
label760:
mtlo $21
mflo $21
ori $21, $0, 0xb3ea
ori $1, $0, 0x7ec2
multu $1, $21
jal label768
sw $21, 74($1)
label768:
mflo $1
beq $0, $0, ToJal775
nop
ToJr775:
sw $31, 8576($0)
ori $31, $0, 0xedd4
jr $31
mtlo $31
ToJal775:
jal ToJr775
mflo $1
mflo $2
ori $27, $0, 0x2a90
multu $27, $25
lh $25, 89($27)
mflo $27
lui $3, 0x7fff
ori $3, $3, 0xfffe
multu $3, $26
jal label790
addi $26, $3, 0
label790:
mtlo $3
mflo $3
ori $18, $0, 0x4999
ori $29, $0, 0x1256
multu $29, $18
sw $18, 97($29)
mtlo $29
mflo $29
beq $0, $0, ToJal804
nop
ToJr804:
sw $31, 8576($0)
ori $31, $0, 0x1288
jr $31
mtlo $31
ToJal804:
jal ToJr804
mflo $1
mflo $2
ori $15, $0, 0x7ebc
multu $15, $19
jal label815
lh $19, 83($15)
label815:
mflo $15
ori $10, $0, 0x7eb4
multu $10, $27
jal label821
lb $27, 88($10)
label821:
mtlo $10
mflo $10
multu $28, $16
jal label828
mov.s $f1, $f2
label828:
mtlo $28
mfhi $28
mflo $5
ori $16, $0, 0x3674
ori $10, $0, 0xcd0a
ori $8, $0, 0x19f3
sw $10, 81($8)
mtlo $8
mflo $8
lui $24, 0x8000
ori $24, $24, 0x2
ori $5, $0, 0x1
add $25, $24, $5
mtlo $24
mflo $24
beq $0, $0, ToJal847
nop
ToJr847:
jr $31
mtlo $31
ToJal847:
jal ToJr847
mflo $1
mflo $2
ori $10, $0, 0x1f18
ori $26, $0, 0x7eb9
multu $26, $10
jal label856
sb $10, 95($26)
label856:
mtlo $26
mflo $26
beq $0, $0, ToJal864
nop
ToJr864:
addi $31, $31, -2
jr $31
mtlo $31
ToJal864:
jal ToJr864
mflo $1
mflo $2
ori $2, $0, 0x7ece
multu $2, $21
jal label874
lh $21, 90($2)
label874:
mflo $2
multu $4, $13
abs.s $f1, $f2
mtlo $4
mfhi $4
mflo $18
ori $13, $0, 0x3885
beq $0, $0, ToJal886
nop
ToJr886:
multu $31, $31
jr $31
mtlo $31
ToJal886:
jal ToJr886
mflo $1
mflo $2
beq $0, $0, ToJal896
nop
ToJr896:
addi $31, $31, 2
jr $31
mtlo $31
ToJal896:
jal ToJr896
mflo $1
mflo $2
lui $11, 0x8000
ori $11, $11, 0x3
multu $11, $24
addi $24, $11, 10
mtlo $11
mflo $11
lui $11, 0x7fff
ori $11, $11, 0xfffc
ori $3, $0, 0x0
jal label912
add $18, $11, $3
label912:
mtlo $11
mflo $11
beq $0, $0, ToJal920
nop
ToJr920:
sw $31, 8576($0)
ori $31, $0, 0x268a
multu $31, $31
jr $31
mtlo $31
ToJal920:
jal ToJr920
mflo $1
mflo $2
ori $20, $0, 0x8dd8
ori $12, $0, 0x1e6b
sh $20, 79($12)
mtlo $12
mflo $12
lui $26, 0xefb0
ori $26, $26, 0xff97
lui $22, 0x1922
ori $22, $22, 0xf8b0
jal label937
add $25, $26, $22
label937:
mflo $26
lui $20, 0x7fff
ori $20, $20, 0xffb3
multu $20, $12
lh $12, 77($20)
mtlo $20
mflo $20
ori $28, $0, 0x7eda
lw $4, 70($28)
mflo $28
ori $2, $0, 0x97a9
ori $19, $0, 0x7ee1
jal label954
sw $2, 63($19)
label954:
mtlo $19
mflo $19
lui $13, 0xffff
ori $13, $13, 0x8002
ori $18, $0, 0x7ffe
sub $30, $13, $18
mflo $13
ori $5, $0, 0x77e9
lui $19, 0xffff
ori $19, $19, 0xffbc
multu $19, $5
jal label966
sw $5, 72($19)
label966:
mtlo $19
mflo $19
ori $8, $0, 0x3688
lui $18, 0x7fff
ori $18, $18, 0xffae
multu $18, $8
jal label975
sb $8, 82($18)
label975:
mflo $18
multu $15, $2
jal label983
add.s $f1, $f2, $f3
label983:
mfhi $15
mflo $24
ori $2, $0, 0xa2a6
jal label990
abs.d $f1, $f2
label990:
mtlo $28
mfhi $28
mflo $15
ori $4, $0, 0x84ea
jal label997
mov.s $f1, $f2
label997:
mtlo $22
mfhi $22
mflo $6
ori $9, $0, 0xf190
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