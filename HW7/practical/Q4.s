; 402105868 402105868
extern scanf
extern printf
global asm_main
section .data
scanf_format: db "%1500s",0
format: db "%d",10,0
first: db "abababa11",0 
second: db "ababaaaaaaba11",0
section .text
asm_main: ; 0 is when two strings are not same.  1 is the case they are same
    sub rsp, 8
    lea r8,first
    lea r9, second
checkLoop:
    mov al, [r8]
    mov bl, [r9]
    cmp al, 0
    je first_string_over
    cmp bl, 0
    je answer_is_0
    cmp al, bl
    jne answer_is_0
    inc r8
    inc r9
    jmp checkLoop
first_string_over:
    cmp bl,0
    jne answer_is_0
answer_is_1:
    mov rax, 1
    mov rdi, format
    mov rsi, rax
    call printf
    jmp prologe
answer_is_0:
    mov rax, 0
    mov rdi, format
    mov rsi, rax
    call printf
prologe:
        add rsp, 8
        ret