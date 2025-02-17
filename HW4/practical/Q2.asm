# 402105868 402105868
.data
	space: .asciiz " "
	newline: .asciiz "\n"
	num1: .word -22 
	num2: .word -2
	num3 : .word -24
	max_value: .word 0
	min_value: .word 0
	max_value1: .word 0
	min_value1: .word 0
	mid_value: .word 0
	one: .word 1

.text 
.globl main
main:
.macro create
    andi $t1 , $t0  , 1 
    srl $t1 ,$t1 , 0  # store 1th bit

    andi $t2 , $t0 , 2
    srl $t2 , $t2 , 1 # store 2th bit

    andi $t3 , $t0 , 4
    srl $t3 , $t3 , 2 # store 3th bit


    andi $t4 , $t0 , 8
    srl $t4 , $t4 , 3 # store 4th bit

    andi $t5 , $t0 , 16
    srl $t5 , $t5 , 4 # store 5th bit
.end_macro
.macro print_rev_bin
 	print_int($t1)
 	print_int($t2)
 	print_int($t3)
 	print_int($t4)
 	print_int($t5)
 	print_space
.end_macro 
.macro print_int $rs
	move $a0 , $rs
	li $v0  , 1
	syscall
.end_macro 
.macro print_space()
        li $v0 , 4
        la $a0 , space
        syscall
    .end_macro
.macro print_newline
        li $v0 , 4
        la $a0 , newline
        syscall
.end_macro
	li $v0 , 5
  	syscall
  	sw $v0 , num1
 	
 	li $v0 , 5
 	syscall
 	sw $v0 , num2
 	
 	
 	li $v0 , 5
 	syscall
 	sw $v0 , num3

    lw $s0 , num1
    lw $s1 , num2
    lw $s2 , num3


# print max value:

	lw $t0, num1
	lw $t1, num2
	
	sub $t2, $t0,$t1
	sra $t2,$t2,31 # msk=-1  if a<b and 0 else.
	
    and $t3 , $t2 , $t1 # t3 = b and msk
    not $t2 , $t2 #msk=~msk
    and $t4 , $t0 , $t2 # t4= a and ~msk

    add $t8 , $t4 , $t3
    sw $t8 , max_value1
	


    lw $t0, max_value1
	lw $t1, num3
	
	sub $t2, $t0,$t1
	sra $t2,$t2,31 # msk=-1  if a<b and 0 else.
	
    and $t3 , $t2 , $t1 # t3 = b and msk
    not $t2 , $t2 #msk=~msk
    and $t4 , $t0 , $t2 # t4= a and ~msk

    add $t8 , $t4 , $t3
    sw $t8 , max_value

    li $v0 , 1
    lw $a0 , max_value
    syscall
     print_space
    
    

#print min_value

	lw $t0, num1
	lw $t1, num2
	
	sub $t2, $t1,$t0
	sra $t2,$t2,31 # msk=-1  if a>b and 0 else.
	
    and $t3 , $t2 , $t1 # t3 = b and msk
    not $t2 , $t2 #msk=~msk
    and $t4 , $t0 , $t2 # t4= a and ~msk

    add $t8 , $t4 , $t3
    sw $t8 , min_value1   #t8 =  max value
	
    # li $v0 , 1
	# add $a0 , $a0 , $t8
	# syscall						# execute

    lw $t0, min_value1
	lw $t1, num3
	
	sub $t2, $t1,$t0
	sra $t2,$t2,31 # msk=-1  if a<b and 0 else.
	
    and $t3 , $t2 , $t1 # t3 = b and msk
    not $t2 , $t2 #msk=~msk
    and $t4 , $t0 , $t2 # t4= a and ~msk

    add $t7 , $t4 , $t3
    sw $t7, min_value  # t7 = min value

    lw $t8 , max_value
    lw $t7 , min_value


    add $s3 , $s0 , $s1
    add $s3 , $s3 , $s2
    sub $s3 , $s3  ,$t8
    sub $s3 , $s3  ,$t7
    move $t6 , $s3 # $t6 = mid value
    sw $s3 , mid_value #s3 = mid value

    li $v0 , 1
    move $a0 , $t6
    syscall

    print_space

    li $v0 , 1
    lw $a0 , min_value
    syscall

    print_newline


    # from here brief: and, shift, and, shift, ... for each one to extract bits
    lw $t0, max_value
	create
print_rev_bin
    lw $t0, mid_value
	create
print_rev_bin
    lw $t0, min_value
	create
print_rev_bin