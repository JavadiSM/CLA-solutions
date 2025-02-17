# 402105868 402105868
.data

.text
.globl main
main:
	li $t1 , 2
	li $t2 , 3
	li $t3 , 4
	# 0< a+b-c
	add $t4 , $t1 , $t2
	sub $t4 , $t4 , $t3
	addi  $t4 ,$t4, -1
	# 0=< a+b-c -1
	srl $t4 , $t4 , 31 # faghat bite alamat bemoone
	
	# 0< b+c-a
	add $t5 , $t2 , $t3
	sub $t5 , $t5 , $t1 
	addi  $t5 ,$t5 , -1
	# 0=<c+a-b -1
	srl $t5 , $t5 , 31 # faghat bite alamat bemoone
	
	# 0<c+a-b
	add $t6 , $t3 , $t1
	sub $t6 , $t6 , $t2 
	addi  $t6 ,$t6 , -1 
	# 0=<c+a-b -1
	srl $t6 , $t6 , 31 # faghat bite alamat bemoone
	

	li $t7 , 1

	sub $t4 , $t7 , $t4
	sub $t5 , $t7 , $t5
	sub $t6 , $t7 , $t6

	mul $t8 , $t4 , $t5
	mul $t8 , $t8 , $t6

	move $t4, $t8