#402105868 402105868

.data
newline:    .asciiz "\n"
space:      .asciiz " "
.text
.macro print_newLine
	li $v0, 4
	la $a0,newline
	syscall
.end_macro 

.macro print_int $rs
	move $a0, $rs
	li $v0,1
	syscall
	print_newLine
.end_macro
.macro input_int $rs
	li      $v0,5
	syscall
	add    $rs,$v0,$zero
.end_macro 
main:
	input_int $s0
	addi    $s0,$s0, 1  # +1 null terminator

	move    $a0,            $s0                            # Request $s0 bytes
	jal alloc
	move    $s1,            $v0

	# reading string
	li      $v0, 8
	move    $a0, $s1
	move    $a1, $s0
	syscall
	addi    $s0,$s0,  -1





	input_int $s2
	addi    $s2, $s2, 1   # +1 null terminator

	move    $a0,            $s2                            # Request $s2 bytes
	jal alloc
	move    $s3,            $v0

	# string
	li      $v0, 8
	move    $a0, $s3
	move    $a1, $s2
	syscall
	addi    $s2,$s2,  -1





	li $s4, 1#i
	li $s5, 0 # out

loop:
	bgt $s0, $s4, printing
	
	jal matches
	beq $v0, $zero, printing
	addi $s5, $s5, 1


printing:
	print_int $s5
	
End_of_loop_work:
	addi $s4, $s4, 1

	bgt $s4, $s2, exit
	j loop


matches:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	bgt $s0, $s2, mismatch

	#  last $s0 chars
	sub $t0, $s4,$s0
	add $t0, $s3, $t0            


cmp: # compare each char
#first of str
	lb $t2, 0($s1)
# first of regex
	lb $t3, 0($t0)


	bne $t2,$t3, mismatch

	addi $s1,$s1, 1
	addi $t0,$t0, 1
	subi $s0,$s0, 1
	bne $s0,$0, cmp

	# regex matches
	li $v0, 1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 20
	jr $ra

mismatch:
	li $v0, 0
	lw $s0,0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 20
	jr $ra
	
	
	
.globl alloc	
alloc: 
	li $v0, 9
	syscall
	jr $ra
	


exit: