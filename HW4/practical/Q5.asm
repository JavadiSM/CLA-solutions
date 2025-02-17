# 402105868 402105868
.data 
    abcd: .word 1, 3, 5, 7  # ax3,bx2,cx,d
.text
.globl Q
Q:
	la $s0,  abcd
	li $v0, 5
	syscall                    # x int
	move $t0, $v0
	
	mul $t1, $t0, $t0 #x2
	mul $t2, $t1, $t0 #x3
	
	lw $t3, 8($s0)
	mul $t0, $t0, $t3 # cx
	
	lw $t3, 4($s0)
	mul $t1, $t1, $t3 # bx2
	
	
	add $t0, $t0, $t1 # bx2 + cx
	
	
	lw $t3, 0($s0)
	mul $t2, $t2, $t3 #ax3
	
	lw $t3, 12($s0) #d
	
	add $t1, $t2,$t3 #ax3+d
	
	
	add $t0, $t0, $t1

	li $v0,1
	move $a0, $t0
	syscall 
