lw	$4, 0($0)
LOOP:
lw	$1, 0($0)
lw	$2, 4($0)
add	$3, $2, $0
or	$1, $3, $1
add	$5, $2, $4
sw	$5, 16($0)
slt	$6, $2, $5
beq	$2, $3, LOOP
add	$1, $1, $4