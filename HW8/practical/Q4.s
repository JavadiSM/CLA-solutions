# 402105868 402105868
# by editing pourias sample codes in github (:
.macro enter size
	stmg	%r6, %r15, 48(%r15)
	lay	%r15, -(160+\size)(%r15)
.endm

.macro leave size
	lay	%r15, (160+\size)(%r15)
	lmg	%r6, %r15, 48(%r15)
.endm

.macro ret
	br	%r14
.endm

.macro call func
	brasl	%r14, \func
.endm

.macro print_long	# Output is in r3
	enter	0
	larl	%r2, pif
	call	printf
	leave	0
.endm

.macro read_long
	enter	8
	larl	%r2,    rif
	lay	%r3,    160(%r15)
	call	scanf
	lg	%r2,    160(%r15)
	leave	8
.endm
.macro print_yes	# Output is in r3
	enter	0
	# larl	%r2, yesss
	call	printf
	leave	0
.endm



.macro print_no	# Output is in r3
	enter	0
	# larl	%r2, nooo
	call	printf
	leave	0
.endm
.data
.align    8
rif:	.asciz	"%ld"
.align    8
pif:	.asciz	"%ld\n"
.align    8

.text
.global    main

main:
	enter	0	
	read_long
	lgr    %r9,%r2

	read_long
	lgr    %r8,%r2


    xgr	%r12,    %r12
    xgr	%r10,    %r10
Mult_LOOP: 
    cgfi    %r8,    0
    je    end
    lgfi    %r10,    1   
    NR    %r10,		%r8
    cgfi    %r10,	0
    je    dntADD
    agr    %r12,    %r9
dntADD:
    sll    %r9,    1
    srl    %r8,    1
    j    Mult_LOOP

end:
    lgr    %r3,%r12
	print_long
	leave	0
    xgr	%r2,    %r2
	ret
