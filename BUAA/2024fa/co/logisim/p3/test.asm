.text
ori $t0, $0, 1
lui $t1, 1
main:
ori $1, $0, 1
lui $2, 12834
ori $2, $2, 12394
sw $2, 0($0)
add $0, $0, $2
sw $0, -100($2)
sub $2, $2, $2
ori $2, $2, 100
sw $2, 0($0)
lw $t3, 0($0)
add $t1, $t1, $t3
beq $t0, $t1, exit
j main
exit:
sw $t0, 100($0)
