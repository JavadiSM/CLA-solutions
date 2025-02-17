# 402105868 402105581
#nemoone voroodi ha
.data
num1: .word -23
num2: .word -223
max_value: .word -10000000
one: .word 1
newline: .asciiz "\n"

.text 
.globl main
main:
	la $t1, num1
	la $t2, num2
	la $v0, max_value
	
	lw $t0, 0($t1) # a
	lw $t1, 0($t2) # b
	
	sub $t2, $t1,$t0
	sra $t2,$t2,31
	addi $t2,$t2, 1
	
	lw $t3, one($zero)
	# baraye rikhtan max. moshabeh p*a + (1-p)b = c
	sub $t3, $t3,$t2
	mul $t3,$t3,$t0 # p*a
	mul $t2,$t2,$t1 # (1-p)b
	add $t0,$t2,$t3
	
	sw $t0, 0($v0)
	

	#optional- just to see results
	addi $v0, $zero, 1
	add $a0, $zero, $t0
	syscall	# tamam
