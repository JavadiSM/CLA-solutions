# 402105868 402105581
# inja voroodi hast
.data
array:  .word   10, 20, 30, 40, 30, 20, 10  # arbitrary array of length 7
length: .word   7
one:    .word   1 # huh?

.text
.globl  main
main:
	la      $t0,    array
	# vaghteshe load konim, az array[0] ta array[6] miran to $t0 t1 ta $t7.
	lw      $t1,    0($t0)
	lw      $t2,    4($t0)
	lw      $t3,    8($t0)
	lw      $t4,    12($t0)
	lw      $t5,    16($t0)
	lw      $t6,    20($t0)
	lw      $t7,    24($t0)

	sub     $s0,    $t1,        $t7
	sub     $s1,    $t2,        $t6
	sub     $s2,    $t3,        $t5

	or      $s3,    $s0,        $s1
	or      $s3,    $s3,        $s2

	# tedade shifta ziad bood vala
	.macro Shift ($shift)
		srl     $s4,    $s3,   $shift
		or      $s3,   $s3,   $s4
	.end_macro

	Shift (16)
	Shift (8)
	Shift (4)
	Shift (2)
	Shift (1)

	andi    $s3,    $s3,        1
	xori    $s3,    $s3,        1

	li      $v0,    1
	add    $a0,    $s3,		$zero #tamam.