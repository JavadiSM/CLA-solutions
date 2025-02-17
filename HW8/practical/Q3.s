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

.macro read_long	# Input is in r2
	enter	8
	larl	%r2, rif
	lay	%r3, 160(%r15)
	call	scanf
	lg	%r2, 160(%r15)
	leave	8
.endm
.macro restoreN
    larl %r5 , n
    lg %r8 , 0(%r5) # r8 = n
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
rsf:	.asciz	"%s"
.align 8
psf:	.asciz	"%s"
.align 8
rcf:	.asciz	"%c"
.align 8
pcf:	.asciz	"%c\n"
.align 8

.align 8
n:	.space	8
.align 8
deciSize: .space 8
.align 8
biSize: .space 8
.align 8
decimal: .space 4000
.align 8
binary: .space 4000
.align 8

.align 8
no: .asciz "nah\n"
.align 8
yes: .asciz "yeah\n"

.text
.global main

main:
	enter	0	
 	lgfi	%r3, 0
    read_long
    stgrl	%r2, n	# store the n in n
	larl %r11 , decimal
    larl %r12 , binary
    xgr		%r7, %r7    # r7=i
    restoreN
    larl %r7 , decimal
Loop:
    cgfi	%r8, 0	# compare R8 with size (64bit)
	je		cont
    lgr %r3 , %r8
    lgfi %r4  , 10
	dsgr	%r2, %r4	# R3 / R4 , Quotient in R3, Remainder in R2
    agfi %r2 , 48
    stc %r2 , 0(%r7)
    lgr %r8 , %r3
    agfi	%r7, 1		# i++
	j	Loop
cont:
    sgr %r7 , %r11
    stgrl %r7 , deciSize
    larl %r5 , deciSize
    restoreN
    lgfi %r9 , 0
    larl %r7 , decimal
Loop3:
    cgrl	%r9, deciSize	# compare R8 with size (64bit)
	je		cont3   
    agrk %r5 ,%r9 ,%r7
    lgrl %r4 , deciSize
    agfi  %r4 , -1 
    agrk %r6 , %r7 , %r4 
    sgr %r6 , %r9
    lgb %r5 , 0(%r5)
    lgb %r6 , 0(%r6) 
    cgr %r5 , %r6
    jne noCase
    agfi %r9 , 1
    j Loop3
cont3: 
    restoreN
    larl %r7 , binary
Loop5:
    cgfi	%r8, 0	# compare R8 with size (64bit)
	je		cont5
    lgr %r3 , %r8
    lgfi %r4  , 2
	dsgr	%r2, %r4	# R3 / R4 , Quotient in R3, Remainder in R2
    agfi %r2 , 48
    stc %r2 , 0(%r7)
    lgr %r8 , %r3
    agfi	%r7, 1		# i++
	j	Loop5
cont5:
    lgr %r7 , %r12
    stgrl %r7 , biSize
    restoreN
    lgfi %r9 , 0
    larl %r7 , binary
Loop6:
    cgrl	%r9, biSize	# compare R8 with size (64bit)
	je		cont6   
    agrk %r5 ,%r9 ,%r7
    lgrl %r4 , biSize
    agfi  %r4 , -1 
    agrk %r6 , %r7 , %r4 
    sgr %r6 , %r9 
    lgb %r5 , 0(%r5)
    lgb %r6 , 0(%r6) 
    cgr %r5 , %r6
    jne noCase
    agfi %r9 , 1
    j Loop6
cont6: 
    j yesCase
	leave	0
 	xgr	%r2, %r2
	ret
yesCase:
    larl %r2 , yes
    call printf
	j endii
noCase:
    larl %r2 , no
    call printf
endii:
	leave	0
    xgr	%r2, %r2
	ret
