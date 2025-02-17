section .data        
input:  db "%s", 0      

int_format:  db "%hd", 0                   
cmp_str: db "cmp", 0
cmp_out:     db "Comparison: %hd", 10, 0
swap_str: db "swap", 0
div_str: db "div", 0
mul_str: db "mul", 0
Yeah: db "YES", 10, 0
NAH: db "NO", 10, 0
exit_str: db "exit", 0
err_out: db "Invalid command!", 10, 0
cmd_buffer:  resb 16                             
mul_out: db "Multiplication: %hd", 10, 0
msb_str: db "msb", 0
msb_message: db "%d", 10, 0
lsb_str: db "lsb", 0
lsb_message: db "%d", 10, 0
div_out: db "Quotient and Remainder: %hd %hd", 10, 0
div_error: db "divisor is zero", 10, 0
overflow_str: db "overflow", 0
section .bss
	num resw 4
    index resb 4
section .text
extern  scanf
extern  printf
extern strcmp
global  asm_main

asm_main:
	sub rsp, 72                             

	mov rdi, int_format           
    mov rsi, num                 
    call scanf

    mov rdi, int_format           
    mov rsi, num+2                 
    call scanf

    mov rdi, int_format           
    mov rsi, num+4                 
    call  scanf
    mov rdi, int_format           
    mov rsi, num+6                 
    call scanf

read_next_command:
     
    lea     rdi, [input]
    lea     rsi, [cmd_buffer]
    call    scanf

     
    lea     rdi, [cmd_buffer]
    lea     rsi, [cmp_str]
    call    strcmp
    test    rax, rax
    jz      compare_numbers

    lea     rsi, [swap_str]
    call    strcmp
    test    rax, rax
    jz      swap_numbers

    lea     rsi, [mul_str]
    call    strcmp
    test    rax, rax
    jz      MULTK

    lea     rsi, [div_str]
    call    strcmp
    test    rax, rax
    jz      divide_numbers

    lea     rsi, [msb_str]
    call    strcmp
    test    rax, rax
    jz      msb_calc

    lea     rsi, [lsb_str]
    call    strcmp
    test    rax, rax
    jz      lsb_calc

    lea     rsi, [overflow_str]
    call    strcmp
    test    rax, rax
    jz      overflow_calc

    lea     rsi, [exit_str]
    call    strcmp
    cmp    rax, 0
    je       ext
invalid_command:
    mov     rdi, err_out
    xor     rax, rax
    call    printf
    jmp     read_next_command
ext:
    add     rsp, 80
    ret
compare_numbers:
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r12w, [rdx]

    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r13w, [rdx]
    cmp r12w, r13w         
    jg  greater_r12w      
    mov r14w, r13w        
    jmp end_comparison   
    greater_r12w:
    mov r14w, r12w        
    end_comparison:
     
    lea     rdi, [cmp_out]
    movzx rsi, r14w     
    call    printf
    jmp     read_next_command

MULTK:
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r12w, [rdx]
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r13w, [rdx]
    imul    r12w, r13w
    lea     rdi, [mul_out]
    movzx     rsi, r12w
    call    printf
    jmp     read_next_command
swap_numbers:
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r12w, [rdx]

    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rcx, byte [index]     
    shl     rcx, 1                 
    add     rcx, num               
    mov     r13w, [rcx]

    mov [rcx], r12w
    mov [rdx], r13w
    jmp read_next_command


divide_numbers:
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r12w, [rdx]

    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r13w, [rdx]

    cmp r13w, 0
    jne continue_divide
    mov rdi, div_error
    call printf
    jmp read_next_command

    continue_divide:
    mov ax, r12w
    cwd
    idiv r13w

    mov rdi, div_out   
    movsx rsi, ax        
    movsx rdx, dx        
    call printf        

    jmp read_next_command

lsb_calc:
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r12w, [rdx]

    movzx r12, r12w
    bsf rax, r12

    mov rdi, msb_message   
    mov rsi, rax        
    call printf        

    jmp read_next_command


overflow_calc:
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r12w, [rdx]

    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl     rdx, 1                 
    add     rdx, num               
    mov     r13w, [rdx]

    add r12w, r13w
    jo overflow_occured
    mov rdi, NAH
    call printf
    jmp read_next_command
    overflow_occured:
    mov rdi, Yeah
    call printf
    jmp read_next_command

msb_calc:
    mov rdi, int_format            
    mov rsi, index
    call scanf
    movzx   rdx, byte [index]     
    shl rdx, 1                 
    add rdx, num               
    mov r12w, [rdx]

    movzx r12, r12w
    bsr rax, r12

    mov rdi, msb_message   
    mov rsi, rax        
    call printf        

    jmp read_next_command