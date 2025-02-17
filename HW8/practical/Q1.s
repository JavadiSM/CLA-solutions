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


.macro print_long
	enter	0
	larl	%r2, pif
	call	printf
	leave	0
.endm

.macro ret
	br	%r14
.endm

.macro call func
	brasl	%r14, \func
.endm

.macro read_long
	enter	8
	larl	%r2, rif
	lay	%r3, 160(%r15)
	call	scanf
	lg	%r2, 160(%r15)
	leave	8
.endm


.macro print_yes	# Output is in r3
	enter	0
	larl	%r2, yesss
	call	printf
	leave	0
.endm



.macro print_no	# Output is in r3
	enter	0
	larl	%r2, nooo
	call	printf
	leave	0
.endm

.data
.align 8
rif:	.asciz	"%ld"
.align 8
pif:	.asciz	"%ld"
.align 8
rsf:	.asciz	"%s"
.align 8
psf:	.asciz	"%s"
.align 8
rcf:	.asciz	"%c"
.align 8
pcf:	.asciz	"%c"
.align 8
yesss:	.asciz	"YES\n"
.align 8
nooo:	.asciz	"NO\n"

.align 8

size:	.zero	8
array:	.zero	16000

.text
.global main

main:
	enter	0	# when calling functions. this allocates 0 extra to 160 in stack
	read_long
	stgrl	%r2, size	# store the size of array in size variable
	larl	%r6, array	# save the relative address of array to R6
	xgr		%r7, %r7
    xgr %r8,%r8
get_array:
	cgrl	%r7, size	# compare R7 with size (64bit)
	je		print_array
	read_long
	stg		%r2, 0(%r6)	# store the input data in array[i]
    agr %r8,%r2
    cgfi %r8,1
    je success_branch
    xgr %r9,%r9
checkLoop:
    lgr %r10 , %r9
    msgr %r10 , %r10
    cgr %r10 , %r8
    je success_branch
    agfi %r9 , 1
    cgr %r9 ,  %r8
    je no_branch
    j checkLoop
no_branch:
    print_no
    j continue
success_branch:
    print_yes
continue:
	agfi	%r6, 8		# Increase the address pointer because each element is 8byte
	agfi	%r7, 1		# i++
	j	get_array
print_array:
	leave	0 # restore from stack 
 	xgr	%r2, %r2
	ret
