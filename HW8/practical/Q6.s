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

.macro print_long
	enter	0
	larl	%r2, pif
	call	printf
	leave	0
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
.align 8
rif:	.asciz	"%ld"
.align 8
pif:	.asciz	"%ld\n"
.align 8
pcf:	.asciz	"%c"
.align 8

size:	.zero	8
.align 8
array:	.zero	8000
.text
.global main

main:
	enter	0	# when calling functions. this allocates 0 extra to 160 in stack
	read_long
	stgrl	%r2, size	# store the size of array in size variable
	larl	%r6, array	# save the relative address of array to R6
	xgr		%r7, %r7
get_array:
	cgrl	%r7, size	# compare R7 with size (64bit)
	je		print_array
	read_long
	stg		%r2, 0(%r6)	# store the input data in array[i]
	agfi	%r6, 8		# Increase the address pointer because each element is 8byte
	agfi	%r7, 1		# i++
	j	get_array
print_array:

	larl	%r2, array
	xgr		%r3, %r3
	agr		%r3, %r7
	call	sum_operation

    lgfi	%r3, 0
	agr		%r3, %r2
	print_long
	leave	0 # restore from stack 
 	lgfi	%r2, 0
	ret
sum_operation:
	stg		%r14, 120(%r15)	 # Save the return address (r14)
	xgr		%r4, %r4
	lg		%r5, 0(%r2)	# load array[i] in R3
	agr		%r4, %r5
sum_loop:
	agfi	%r2, 8
	agfi	%r3, -1
	cgfi	%r3, -1		# compare R7 with -1 (64bit)

	je		end
	lg		%r5, 0(%r2)	# load array[i] in R3
	agr		%r4, %r5
	j sum_loop
end:
	xgr		%r2, %r2
	agr		%r2, %r4
	lg		%r14, 120(%r15)	 # Restore the saved return address
	ret
