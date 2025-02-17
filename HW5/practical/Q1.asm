# 402105868 402105868
.data
	newLine: .asciiz "\n"
.text
.macro update_stack
	subi $s0,$s0,4
	sw $t1, 0($s0)
.end_macro 


.macro load_operands
	lw $t0,0($s0)
	lw $t1, -4($s0)
.end_macro 


.macro read_line #t0 containss ascii summary of input characters
	add	 	$t0,$zero,$zero
	
	li 		$v0,12
	syscall
	add 		$t0,$t0,$v0
	
	li 		$v0,12
	syscall
	add 		$t0,$t0,$v0
	
	li 		$v0,12
	syscall
	add 		$t0,$t0,$v0
	
	li 		$v0,12
	syscall # for consuming newline
	
.end_macro 

.macro print_newLine
	li $v0, 4
	la $a0,newLine
	syscall
.end_macro 
.macro print_last
	li $v0,1
	lw $a0, 0($s0)
	syscall
	print_newLine
.end_macro 
.globl main
main:
#  psh = 331 add = 297 sub = 330 mul = 334 ext = 337 pop = 335
	

	li $a0, 4 
	jal alloc_2n 
	move $s0,$v0 # new stack pointer is s0
	move $s6,$s0 # frame pointer
	li $s5, 4 # size
runLoop:
	read_line
	li $t1, 337
	beq $t0, $t1, Ext
	# ext = 337
	li $t1, 331
	beq $t0, $t1,Push
	#  psh = 331
	li $t1, 335
	beq $t0, $t1,Pop
	# pop = 335
	
	#load_operands #t0 and t1 will be operands
	
	li $t1, 297
	beq $t0, $t1,Add 
	#add = 297
	li $t1, 330
	beq $t0, $t1,Sub
	# sub = 330 
	li $t1, 334
	beq $t0, $t1,Mul
	#mul = 334
	returnLabel:
	update_stack
	j runLoop
Push:
	addi $s0,$s0,4
	li $v0,5
	syscall
	sw $v0, 0($s0)
	sub $t3,$s0,$s6
	addi $t3, $t3, 4
	beq $t3,$s5, behine

	j runLoop
	
Pop:
	print_last
	subi $s0,$s0,4
	j runLoop
Mul:
	load_operands
	mul $t1,$t0,$t1
	j returnLabel
	
Sub:
	load_operands
	sub $t1,$t0,$t1
	j returnLabel

Add:
	load_operands
	add $t1,$t1,$t0
	j returnLabel

	
Ext:
	li $v0,17
	syscall #terminating program	








behine:
	add $s5,$s5,$s5
	move $a0,$s5
	jal alloc_2n 
	move $s2,$v0 # temp sp
	move $s3,$s2 # temp fp
copyArr:
	lw $t3,	0($s6)
	sw $t3, 0($s2)
	addi $s2,$s2,4
	addi $s6,$s6,4
	bne $s6,$s0,copyArr
	
	#unrolling
	lw $t3,	0($s6)
	#unrolling
	sw $t3, 0($s2) 
	
	# sp
		move $s0,$s2
	# fp 
		move $s6,$s3 
	
	j runLoop
	
	
	
# a callable function
alloc_2n : 
	li $v0, 9
	syscall
	jr $ra
