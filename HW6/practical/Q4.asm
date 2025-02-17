# 402105868 402105868
.data
matris: .byte 1, 2, 3, 4  
          .byte 5, 6, 7, 8  
          .byte 9, 10, 11, 12  
          .byte 13, 14, 15, 16
newline: .asciiz "\n"
space: .asciiz " "







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
.end_macro
.macro input_int $rs
	li      $v0,5
	syscall
	add    $rs,$v0,$zero
.end_macro 
.globl main

# PYTHON:

#  def rotate_matrix_1d(matrix):  
    # Create a new 1D list to hold the rotated values  
#     rotated = [0] * 16  # Since we know it's a 4x4 matrix, we initialize a list of size 16  

 #    for i in range(4):  
  #       for j in range(4):  
            # Applying the transformation for 90 degree clockwise rotation  
    #         rotated[j * 4 + (3 - i)] = matrix[i * 4 + j]  

 #    return rotated  

# 1D matrix representation  
# matrix = [1, 2, 3, 4,  
 #          5, 6, 7, 8,  
 #          9, 10, 11, 12,  
#           13, 14, 15, 16]  

# print("Original matrix as 1D array:")  
# print(matrix)  

# Rotate the matrix  
# rotated_matrix = rotate_matrix_1d(matrix)  

# print("\nRotated matrix as 1D array:")  
# print(rotated_matrix) 
main:
    	la   $t0, matris  # Load address of the matrix into $t0  
    	li $v0,9
    	li $a0,16
    	syscall
    	move $s0,$v0
    	li $s1,4 # while i< 4
	li $t1,0 # i
outter:
	li $t2,0 # j
	inner:
		sll $t3,$t1,2 # 4i
		add $t3,$t3,$t2 # 4i + j
		lb $t3, matris($t3)
	
		sll $t4,$t2,2 # 4j
		
		neg $t5,$t1 # -i
		addi $t5,$t5,3 #3-i
		add $t4,$t4,$t5 # 4j + 3-i
	
		add $t4,$t4,$s0 # s0 is address of traversed matrix
	
		sb $t3, 0($t4)
	
		addi $t2,$t2,1
		bne $t2,$s1,inner
	
	addi $t1,$t1,1
	bne $t1,$s1,outter

	
	
	move $a0,$s0
	jal print_matrix
	li $v0,10
	syscall




.globl print_matrix
print_matrix:
    move   $t0,$a0 # address
    li   $t1, 4        #   (4 rows)  
    li   $t2, 4        #  (4 columns)  
    
    
li   $t3, 0
row_loop: # for rows  
    li   $t4, 0
	column_loop:  # for columns  
    	lb   $t5, 0($t0)   # Load byte from matrix
    	  
    	print_int $t5
    
   
    	li   $v0, 4
    	la   $a0, space 
    	syscall 


    	addi $t0, $t0, 1 
    	addi $t4, $t4, 1 
    	bne  $t4, $t2, column_loop

    	print_newLine 

    addi $t3, $t3, 1
    bne  $t3, $t1, row_loop
    jr $ra
