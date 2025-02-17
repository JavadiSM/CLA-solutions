# 402105868 402105868
.data
space:          .asciiz " "
new_line:        .asciiz "\n"
binary_input:   .space  6

.text

.macro dodoi
	print_number($t5)                  # 6th bit
	print_number($t4)                  # 5th bit
	print_number($t3)                  # 4th bit
	print_number($t2)                  # 3rd bit
	print_number($t1)                  # 2nd bit
	print_number($t0)                  # 1st bit
	print_newline()
.end_macro 

.macro  print_newline
	li      $v0,    4                      # syscall 4: print_string
	la      $a0,    new_line
	syscall                                # print newline
.end_macro

.macro  print_number, $n
	li      $v0,    1
	move    $a0,    $n
	syscall
.end_macro

.macro  load_byte_into($rd)
	lb      $rd,    0($t0)
	add     $t0,    $t0,            -1

	addi    $rd,    $rd,            -48
	mul     $rd,    $rd,            $s0
	add     $s0,    $s0,            $s0
.end_macro

.macro and_shift $t
	andi    $t,    $t9,        1
	srl     $t9,    $t9,        1
.end_macro 

.macro load_bytes
	addi    $t0,    $t0,            5 # ac andis 6 om be 1 bayad biad
	load_byte_into($t1)                    # 6th bit
	load_byte_into($t2)                    # 5th bit
	load_byte_into($t3)                    # 4th bit
	load_byte_into($t4)                    # 3rd bit
	load_byte_into($t5)                    # 2nd bit
	load_byte_into($t6)                    # 1st bit
.end_macro 

.macro and_shifts
	and_shift $t0
	and_shift $t1
	and_shift $t2
	and_shift $t3
	and_shift $t4
	and_shift $t5
.end_macro 

.globl  main
main:
	la      $t0,    binary_input

	li      $s0,    1
	li      $v0,    8
	move      $a0,    $t0
	li      $a1,    7
	syscall


	load_bytes
	
	add     $s7,     $t5,            $t6
	add     $s7,     $s7,            $t4
	add     $s7,     $s7,            $t3
	add     $s7,     $s7,            $t1
	add     $s7,     $s7,            $t2

	# 1a
	print_number($s7)
	print_newline



	# 1b first char
	andi    $t1,    $s7,            2
	srl     $t1,    $t1,            1

	andi    $t2,    $s7,            4
	srl     $t2,    $t2,            2

	andi    $t3,    $s7,            8
	srl     $t3,    $t3,            3


	andi    $t6,    $s7,            48
	srl     $t6,    $t6,            4
	print_number($t6)

	li      $s1,    0
	andi    $t8,    $s7,            15     #t8 = x baraye estekhrage 4 bit
	addi    $s1,    $t8,            48     # s1 = x + 48
	add      $s2,    $zero ,$zero # s2 = flg
	or      $s2,    $t1,            $t2
	and     $s2,    $s2,            $t3
	addi      $t7,    $zero, 7
	mul     $s2,    $s2,            $t7
	add     $s1,    $s1,            $s2

	#  1b second char
	li      $v0,    11                     # syscall 11: print_character
	move    $a0,    $s1
	syscall                                # print $s1

	print_newline




	li      $v0,    5
	syscall
	move    $s0,    $v0
	move $t9,$s0
	# and 1, shift 1, and 1, shift 1 ,... 
	and_shifts
	# 1a
	dodoi

	# 2a done
	andi    $t6,    $s0,        48
	srl     $t6,    $t6,        4
	print_number($t6)

	li      $s1,    0
	andi    $t8,    $s0,        15     #t8 = x
	addi    $s1,    $t8,        48     # s1 = x + 48
	li      $s2,    0                  # s2 = flag
	or      $s2,    $t1,        $t2
	and     $s2,    $s2,        $t3
	li      $t7,    7
	mul     $s2,    $s2,        $t7
	add     $s1,    $s1,        $s2

	# 2b done
	li      $v0,    11                 # syscall 11: print_character
	move    $a0,    $s1
	syscall                            # print $s1
