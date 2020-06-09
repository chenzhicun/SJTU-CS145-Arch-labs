LOAD:
lw $1,0($0)
lw $2,4($0)
lw $3,8($0)

add $1,$1,$2
or $4,$1,$2
sll $2,$2,1
slt $5,$3,$2
sub $2,$2,$5
and $6,$2,$5
sll $6,$6,6
sw $4,12($0)
srl $6,$6,4
beq $2,$3,JUMP
and $6,$2,$5

BEQ:
jal END
addi $7,2
andi $1,6
ori $7,5
j LOAD

END:
jr $31