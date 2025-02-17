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
.globl  main
main:
	input_int $s0 #a
	input_int $s1 #b
	#passing agrs
	move    $a0,$s0 
	move    $a1,$s1
	jal     pw
	
	print_int $t2

	j Exfil


pw:
	subi   $sp,$sp,40
	sw      $s0, 0($sp) # a
	sw      $s1, 4($sp) # b
	sw      $ra, 8($sp)
	move    $s0, $a0
	move    $s1,        $a1


	beq     $s1,        $zero,  base       # a^0

	and     $a0,        $s1,    1
	beq     $a0,        $zero,  half_power

        #   case odd power
	move    $a0, $s0
	addi    $a1, $s1 -1
	jal     pw                       # a^b-1
	mul     $t2,$t2,$s0        # (a^b-1)*a
	j       end
base:
	addi    $t2,$zero,1
	j       end

half_power:
	move    $a0, $s0
	sra     $a1, $s1, 1
	jal     pw                          # a^b/2
	mul     $t2, $t2, $t2        # result = (a^b-1)^2

end:
	lw      $ra, 8($sp)
	lw      $s1, 4($sp) # b
	lw      $s0, 0($sp) # a

	addiu   $sp,        $sp,   40
	jr      $ra
Exfil:
