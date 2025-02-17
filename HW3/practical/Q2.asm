# 402105868 402105581
.text
.globl main
main:
	li $v0, 6
	syscall
	mov.s $f1, $f0  # a
	
	li $v0, 6
	syscall
	mov.s $f2, $f0  # b
	
	li $v0, 6
	syscall
	mov.s $f3, $f0  # c
	
    mul.s $f4, $f2, $f2        # b**2
    mul.s $f5, $f1, $f3        # a * c
    
    
    l.s $f22, chahar
    mul.s $f5, $f5, $f22  # 4ac
    
    sub.s $f4, $f4, $f5 # b**2 - 4ac
    
    sqrt.s $f4, $f4 # radical(b**2 - 4ac)
    
    add.s $f1, $f1, $f1 # 2a
    neg.s $f2, $f2
    sub.s $f6, $f2, $f4
    div.s $f6, $f6, $f1        # first result
    li $v0, 2
    mov.s $f12, $f6
    syscall
    
    li $v0, 4
    la $a0, new_line # prettier format
    syscall
    
    add.s $f7, $f2, $f4
    div.s $f7, $f7, $f1        # second result
    li $v0, 2
    mov.s $f12, $f7
    syscall

# dade ha
.data 
    new_line: .asciiz "\n"
    chahar: .float 4.0

