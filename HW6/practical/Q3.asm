# 402105868 402105868
.data
newLine: .asciiz "\n"
.text
.globl  main
main:

#########xxxxxx
	li      $v0,5
	syscall
	move    $s0,$v0
########YYYYYY
	li      $v0,5
	syscall
	move    $s1,$v0
########ZZZZZZ
	li      $v0,5
	syscall
	move    $s2,$v0
	
	
	move $a0,$s0
	move $a1,$s1
	move $a2,$s2
	
	jal Tak
	move $a0, $v0
	li $v0,1
	syscall
	li $v0, 4
	la $a0,newLine
	syscall
	li $v0,10
	syscall
	
Tak:
	subi $sp,$sp, 24
	sw $a0, 0($sp) # x
	sw $a1, 4($sp) # y
	sw $a2, 8($sp) # z
	sw $ra, 12($sp) # z
	
	
	blt $zero,$a0,base2
	move $v0,$a1
	j exit
	
base2:
	blt $zero,$a1,base3
	move $v0,$a2
	j exit
	
base3:
	
	blt $zero,$a2,else
	# tak(x - 1, y - 1, z);
	subi $a0,$a0,1
	subi $a1,$a1,1
	jal Tak
	j exit

else:
	move $t0,$a0
	move $a0,$a1
	
	subi $a0,$a0,1
	move $a1,$a2
	move $a2,$t0
	jal Tak
	sw $v0, 16($sp) # tak(y - 1, z, x)
	
	
	lw $a0,4($sp)
	lw $a1,8($sp)
	subi $a1,$a1,1
	lw $a2,0($sp)
	jal Tak # tak(y, z - 1, x)
	
	
	move $a2,$v0
	lw $a1, 16($sp)
	lw $a0,0($sp)
	subi $a0,$a0,1
	jal Tak # tak(x - 1, tak(y - 1, z, x), tak(y, z - 1, x))
	
	
exit:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp,$sp,24
	jr $ra