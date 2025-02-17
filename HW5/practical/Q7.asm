# 402105868 402105868
.data 
poly1: .space 404
poly2: .space 404
poly3: .space 10000
newline: .asciiz "\n"
pw: .asciiz "X^"
pl: .asciiz "+"
.text 
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

    .macro print_array

    li $t2, 0
    li $s6, 0 # flag
    li $s5, 1 # flag for 1
    loop_array: 
        sll $t3, $t2, 2
        add $t4, $t0, $t3   #current element  
        lw $a0, 0($t4)           # Load current element
        beq $a0,$0,conti
        
        
        blt $a0,$0,goOn
        beq $s6, $zero,goOn
        li $v0, 4                # System call for print_string  
        la $a0, pl        # Load address of newline string  
        syscall 
              
        goOn: 
        li $s6,1 
        lw $a0, 0($t4)
        beq $a0,$s5,kkkkkk
        li $v0, 1                # System call for print int  
        syscall  
        kkkkkk:
        sub $a0, $t1,$t2
        subi $a0,$a0,1
        beq $a0,$0,end_loop_array

        li $v0, 4
        la $a0, pw
        syscall  

        sub $a0, $t1,$t2
        subi $a0,$a0,1
        li $v0, 1                # System call for print int  
        syscall
        
        conti:
        addi $t2, $t2, 1
        j loop_array

    end_loop_array:  
    .end_macro

.globl main
main:
	addi		$v0, $0, 5		# system call #5 - input int
	syscall						# execute
	sll $t0,$v0,2
	addi $t0,$t0,4
	move $s2,$t0 # size
	
	li $t2,0
poly1_input:
	addi		$v0, $0, 5		# system call #5 - input int
	syscall						# execute
	sw $v0,poly1($t2)
	addi $t2,$t2,4
	bne $t2,$t0, poly1_input
	
	add $t1, $s2,$0
	la $t0, poly1
	srl $t1, $t1, 2



	addi		$v0, $0, 5		# system call #5 - input int
	syscall						# execute
	sll $t0,$v0,2
	addi $t0,$t0,4
	move $s3,$t0 # size
	
	li $t2,0
poly2_input:
	addi		$v0, $0, 5		# system call #5 - input int
	syscall						# execute
	sw $v0,poly2($t2)
	addi $t2,$t2,4
	move $s3,$t0 # size of poly1
	
	
	
	bne $t2,$t0, poly2_input
	
	move $t1,$s3
	srl $t1, $t1, 2
	
	li $s0,0
outerLoop:
	li $s1,0
	innerLoop:
		add $s7,$s1,$s0
		lw $s6 poly3($s7)
		lw $s5, poly1($s0)
		lw $s4, poly2($s1)
		mul $s4,$s4,$s5
		add $s6, $s6,$s4
		sw $s6 poly3($s7)
	
		addi $s1,$s1,4
		bne $s1,$s3,innerLoop
	
	addi $s0,$s0,4
	bne $s0,$s2,outerLoop
	
	
	add $t1, $s2,$s3
	subi $t1, $t1,4
	li $t0,4
	div $t1, $t1, $t0
	
	la $t0,poly3
print_array
