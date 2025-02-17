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

.macro print_newLine
	li $v0, 4
	la $a0,newLine
	syscall
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


.data
newLine: .asciiz "\n"
N:  .word   3
M:  .word   2
P:  .word   4
A:  .word   1, 2, 3, 4, 5, 6                    # { {1, 2}, {3, 4}, {5, 6} }
B:  .word   8, 7, 6, 5, 4, 3, 2, 1              # { {8, 7, 6, 5}, {4, 3, 2, 1} }
C:  .space  12                                  # N * P, 3 * 4

.text
.globl  main
main:
	addi $sp, $sp, -40
	la      $s0,        A                          # s0 = address of A
	la      $s1,        B                          # s1 = address of B
	la      $s7,        C                          # s7 = address of C
	lw      $a0,        N($0)                     # a0 = N
	lw      $a1,        M($zero)                     # a1 = M
	lw      $a2,        P($zero)                     # a2 = P


	li    $s2, 0 # row init
	li    $s3, 0  # column                    

loop:
	mul     $t0, $s2, $a1
	move    $t1, $s3

	li    $v0,    0 # result so on
sum:
	read $t2, $t0, $s0

	read $t3, $t1, $s1

	mul     $t3, $t3, $t2
	add     $v0, $v0, $t3

	addi    $t0, $t0, 1
	add     $t1, $t1, $a2

	div     $t0, $a1
	mfhi    $t2
	bne     $t2, $zero, sum

	mul     $t2, $s2, $a2
	add     $t2, $t2, $s3

	write $v0, $t2, $s7

	addi    $s3, $s3, 1
	div     $s3, $a2
	mfhi    $t2
	bne     $t2, $zero, loop

	addi    $s2, $s2, 1
	move    $s3, $zero
	div     $s2, $a0
	mfhi    $t2
	bne     $t2, $zero, loop
	
	
	addi $sp, $sp, 40
	j exf



.macro  write $rs, $os, $rd
	add     $rd,        $rd,        $os
	sll     $os,    $os,    2
	sw      $rs,        0($rd)
	sub     $rd,        $rd,        $os
	srl     $os,    $os,    2
.end_macro


.macro  read $rs, $os, $rd
	add     $rd, $rd,  $os
	sll     $os,  $os, 2
	lw      $rs, 0($rd)
	sub     $rd, $rd, $os
	srl     $os, $os, 2
.end_macro


alloc_2n : 
	li $v0, 9
	syscall
	jr $ra
exf: