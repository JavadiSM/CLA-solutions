# 402105868 402105868
.data
newLine: .asciiz "\n"
.text
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

alloc_2n : 
	li $v0, 9
	syscall
	jr $ra
.globl  main
main:
	li      $t9, 4

	input_int $s0 # n
	sll $a0, $s0,2
	addi $a0, $a0,24 # kam nayad
	jal alloc_2n
	move $s1, $v0 
	
	
	addi $s4 , $s0  , -1   #s4 = n-1

	li $t0, 0
loop:
	mul     $t1,        $t0, $t9
	li      $v0,        5                              # syscall 5: read_int
	syscall
	add     $t1, $t1, $s1
	sw      $v0,        0($t1)
	blt     $t0,        $s0, loop

	li      $t0,        0
	j       continue

check_relative_prime:
# a b c
# 0 b c
# c b d
# ...
ocklidus:
	beqz    $a1,        done
	move    $t3,        $a1
	div     $a0,        $a1
	mfhi    $a1
	move    $a0,        $t3
	j       ocklidus

done:
	li      $v0,        0
	subi    $a0,        $a0,                    1
	beqz    $a0,        relatively_prime
	jr      $ra

relatively_prime:
	li      $v0,        1                              # Return 0 if GCD is not 1
	jr      $ra                                        # Return from functio
	
continue:
	li      $s7, 0 # s7 is counter
	li      $t0,        0
	li      $t1,        0
	# searching through all possible pairs
outerLoop:
                      
	addi $t1 , $t0,1        # j <- i
    
	li $t2 , 0
	mul $t5 , $t9 , $t0
	add $t2 , $s1 , $t5
	lw $s6 , 0($t2)  # a[i]
innerLoop:
	li $t2 , 0
        mul $t5 , $t9 , $t1
        add $t2 , $s1 , $t5
        lw $s5 , 0($t2)  #a[j]

        move $a0 , $s5
        move $a1 , $s6
        jal ocklidus
        add $s7 ,$v0 ,$s7
	    
        addi    $t1, $t1, 1
	blt $t1, $s0 , innerLoop

	addi $t0, $t0, 1
	blt $t0 , $s4 , outerLoop

print_int $s7



