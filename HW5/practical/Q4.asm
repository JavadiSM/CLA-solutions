# 402105868 402105868
.macro print_array
    li $t2, 0

    loop_arra1y:  
        bge $t2, $t1, end_loop_arra1y 
        sll $t3, $t2, 2  
        add $t4, $t0, $t3  
        lw $a0, 0($t4) 
        li $v0, 1
        syscall  

        li $v0, 4  
        la $a0, newline  
        syscall  

        addi $t2, $t2, 1 
        j loop_arra1y
    end_loop_arra1y:  
.end_macro
    
    
    
.data
newline: .asciiz "\n"
.text
.globl main
main:
	li $v0, 5
	syscall
	move $t1,$v0 #size in t1
	
	add $t5,$t1,$t1	
	add $t2, $t5, $t5
	move $a0,$t2
	addi $a0,$a0,4
	li $v0, 9
	syscall
	move $t0,$v0 # address of array in t0
	li $t3,0
loop:
	add $t3, $t0,$t2
	li $v0,5
	syscall
	sw $v0, 0($t3)
	subi $t2,$t2,4
	bne $t2, $zero,loop
	
	addi $t0, $t0,4
	
j sort

# code tamrin 4 teori hast
sort:
	#note : $t0, array
	#note : $t1, array_size
	li $t2, 0

outer_loop:
    bge $t2, $t1, end_outer_loop
    li $t3, 0

inner_loop:
    sub $t4, $t1, 1
    bge $t3, $t4, end_inner_loop

    sll $t5, $t3, 2
    add $t5, $t5, $t0
    lw $t6, 0($t5)
    lw $t7, 4($t5)

    ble $t6, $t7, no_swap
    sw $t7, 0($t5)
    sw $t6, 4($t5)

no_swap:
    addi $t3, $t3, 1
    j inner_loop

end_inner_loop:
    addi $t2, $t2, 1
    j outer_loop
end_outer_loop:
print_array
    li $v0, 10                 # Exit program
    syscall
