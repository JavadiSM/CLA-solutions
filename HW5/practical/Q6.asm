# 402105868 402105868
.data
yes:    .asciiz "YES"
no:     .asciiz "NO"
newline: .asciiz "\n"
.text
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
.macro print_int $rs
	li $v0,1
	move $a0, $rs
	syscall
	print_newLine
.end_macro
.macro input_int $rs
	li      $v0,5
	syscall
	add    $rs,$v0,$zero
.end_macro 

.macro print_str $rs
	li      $v0,        4                  # syscall 4: print_string
	move      $a0,       $rs
	syscall
.end_macro

		
.globl main
main:
	li      $t8,        32


	li      $t9,        10
	# addad = d1d2d3
	input_int $s0 # voroodi

	div     $s0,        $t9
	mfhi    $s1                            # d3
	mflo    $t5 #d1d2
	div     $t5,        $t9
	mfhi    $s2                            # d2
	mflo    $s3                            # d1
	


	sgt     $s4,        $s0,    9
	beq     $s4,        1,      dg

	li      $s6,        1
	j       label

dg:
	li      $s6,        2
	sgt     $s4,        $s0,    99
	add $s6, $s6,$s4
	
label:
	li $t4, 0                  #t4=i
	
	
	# init
	li $a1, 1
	li $a2, 1
	li $a3, 1
Loop:
	mul     $a1, $a1, $s1
	mul     $a2, $a2, $s2
	mul     $a3, $a3, $s3



	addi    $t4, $t4, 1
	blt     $t4, $s6, Loop

	add     $a1, $a1, $a2
	add     $a1, $a1, $a3
	
	
	beq     $a1, $s0,     Yes
	la $t0,no
	print_str $t0
	
	j exf
Yes:
	la      $t0,        yes
	print_str $t0
exf: