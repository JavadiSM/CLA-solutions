# 402105868 402105868
.data
newLine: .asciiz "\n"
buffer: .space 30
yeah: .asciiz "yeah\n"
nah: .asciiz "nah\n"
.text
# go to reach \0
.macro get_size 
	la $t0, buffer
loopforgetsize:
    lb   $t1, 0($t0)
    beq  $t1,$0, endforgetsize

    addi $t0, $t0, 1
    j loopforgetsize

endforgetsize:
	la $t1 ,buffer
	sub $t3, $t0, $t1 

.end_macro 


.globl  main
main:

	li $v0,8
	la $a0, buffer
	li $a1, 12
	syscall
	get_size
	#stores in $t3
	
	la $s0,buffer
	li $a0,0
	addi $a1, $t3,-2
	
	
	jal is_palindrome
	bne $v0,$zero,hast
	
	li $v0,4
	la $a0,nah
	syscall
	j eazy
	hast:
	li $v0,4
	la $a0, yeah
	syscall
	eazy:
	li $v0,10
	syscall
is_palindrome: #start at #a0 and end at $a1. assume s in always $s0
# in python:
#def is_palindrome(s, start, end):   
#    if start >= end:  
#        return True  # It's a palindrome  

#    # Check characters at the start and end  
#    if s[start] != s[end]:  
#        return False  # Not a palindromes  
#    return is_palindrome(s, start + 1, end - 1)  
	blt $a0,$a1, loop
	li $v0,1
	jr $ra
loop:
	addi $sp, $sp,-16
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
	lb $t0, buffer($a0)
	lb $t1, buffer($a1)

	beq $t0,$t1,recurs
	
	li $v0,0
	j end
	
recurs:
	addi $a0, $a0,1
	subi $a1, $a1, 1
	jal is_palindrome
	
end:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 16
	jr $ra
	
.globl alloc	
alloc: 
	li $v0, 9
	syscall
	jr $ra
	
	

.macro print_newLine
	li $v0, 4
	la $a0,newLine
	syscall
.end_macro 


.macro print_int $rs
	move $a0, $rs
	li $v0,1
	syscall
	print_newLine
.end_macro
.macro input_int $rs
	li      $v0,5
	syscall
	add    $rs,$v0,$zero
.end_macro 

