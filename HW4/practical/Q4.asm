# 402105868 402105868
.data


.macro  shift_right_arithmetic $rd, $rs, %n
	addi $sp,$sp,-8
	sw $t1, 0($sp)
	sw $t2, 4($sp)
	andi $t2, $rs, 2147483648
	li $t1, %n
beqz $t1,end
single_right:
	srl     $rd,    $rs,    1
	or     $rd,    $rd,    $t2
	addi     $t1,      $t1,     -1
	bne      $t1,     0,      single_right
	
	lw $t1, 0($sp)
	lw $t2, 4($sp)
	addi $sp,$sp,+8
end:
.end_macro


.macro left_shift $rd, $rs, %n
	addi $sp, $sp,-4
	sw $t1, 0($sp)
	li $t1, %n
	add $rd, $rs, $zero
single_left:
	add $rd, $rd, $rd
	addi $t1, $t1,-1
	bne      $t1,     0,     single_left
	lw $t0, 0($sp)
	addi $sp, $sp, 4
.end_macro 


.text
    .globl  main
main:
	li      $s0,    -8
	shift_right_arithmetic $s0, $s0,    1
	li      $s1,    1
	
	left_shift  $s1, $s1,    4
	
	li	$v0, 1						# syscall 1: print_int
	move	$a0, $s0
	syscall							# print $t0
