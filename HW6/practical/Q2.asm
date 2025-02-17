# 402105868 402105868
.data
newline: .asciiz "\n"
space: .asciiz " "

.macro print_newLine
	li $v0, 4
	la $a0,newline
	syscall
.end_macro 

.macro print_int $rs
	move $a0, $rs
	li $v0,1
	syscall
.end_macro
.macro input_int $rs
	li      $v0,5
	syscall
	add    $rs,$v0,$zero
.end_macro 

.text
.globl  main
main:
	input_int $s0
	li      $s1, 1 #  i
	sllv    $s1, $s1, $s0
	subi    $s1, $s1, 1 # starts from 111...1 n ones
run:
	move    $a0, $s1
	move    $a1, $s0
	jal     matches
	beq     $v0, $zero, continue
print:
	move    $a0, $s1
	move    $a1, $s0
	jal     print_binary
continue:
	subi    $s1, $s1,    1
	bge     $s1, $zero, run
	j end



.globl matches
#  a0 =x , a1 = len
matches:
	sle     $t1, $a1, 1
	seq     $v0, $t1, 1
	beq     $t1, 1, return
  	# t3=  len -1
	subi    $t3, $a1, 1
	# t4 =  len - 2
	subi    $t4, $a1, 2
	#t1 =  nth bit
	srlv    $t1, $a0, $t3  
	srlv    $t2, $a0, $t4
	#t2 = n-1th bit
	andi    $t2, $t2, 1  
	
	
	beq     $t1, 1, is1
is0:
	li      $t9, 1
	sllv    $t9, $t9, $t3
# starts from 111...1 n ones
	subi    $t9, $t9, 1 
	and     $a0, $t9, $a0


	subi    $a1, $a1, 1
	j       matches
is1:
	# next bit 1 v0 is 0
	seq     $v0, $t2, 0 
	beq     $v0, 0, return

	li      $t9, 1
	sllv    $t9, $t9, $t4
# starts from 111...1 n ones
	subi    $t9, $t9, 1
	and     $a0, $t9, $a0


	subi    $a1, $a1, 2
	j       matches

print_binary:                                        # Function label  
	move    $t0, $a1                             # Load length of binary into $t0  
	subi    $t0, $a1, 1                          # Set $t0 to length - 1  

Loop2:                                               # Loop label  
	srlv    $t1, $a0, $t0                        # Shift right $a0 by $t0 bits, result in $t1  
	andi    $t1, $t1, 1                          # Isolate the least significant bit in $t1  
	move    $t9,  $v0                            # Preserve syscall code in $t9  
	move    $t8, $a0                             # Save original number in $t8 
	print_int $t1 				    # Print the bit  
	move    $v0, $t9                             # Restore syscall code  
	move    $a0, $t8                             # Restore original number  
	subi    $t0, $t0, 1                          # Decrement bit index  
	bge     $t0, $zero, Loop2                    # Repeat if $t0 >= 0  

	print_newLine
return: 
	jr      $ra

end: