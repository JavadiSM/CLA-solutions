# 402105868 402105581

.text
.globl main

main:

    li $v0, 5
    syscall                    # Read an integer
    add $t0, $v0  , $t0

    li $v0, 12
    syscall                    # Read a character
    add $t1, $v0 , $t1

    li $v0, 5
    syscall                    # Read another integer
    add , $t2 $t2, $v0

    la $t7 , init_array
    add $s5, $t0 , $t2 # s5 = a+b
    sub $s6 , $t0 , $t2 # s6 = a-b
    sw $s5 , 0($t7)
    sw $s6 , 4($t7)
    addi $t1 , $t1 , -43 # t1 = sign - 43
    add $t1 , $t1 , $t1 # t1 = (sign - 43)*2. ya 0 mishe yani + va 4 yani -
    add $t7 , $t7 , $t1
    lw $s7 , 0($t7)


    add $a0, $s7 , $zero            # Move second integer to $a0 for printing
    li $v0, 1                  # Load system call for print_int
    syscall

.data
    init_array: .word 0, 0