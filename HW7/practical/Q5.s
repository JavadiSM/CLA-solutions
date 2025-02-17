; 402105868 402105868
section .data
scanf_format: db "%1500s",0
print_format: db "ones:%d",10,"zeros:%d",10,0
section .text 
extern scanf
extern printf
global asm_main
asm_main:
        sub rsp,1608
        mov rdi , scanf_format
        mov rsi , rsp
        call scanf
        mov r8,rsp
        mov rcx,0
        mov rdx,0
main_loop:
        mov al , [r8]
        cmp al,0
        je end_main_loop
        cmp al,'0'
        je rdx_inc_0
rcx_inc_1:
        add rcx,1
        jmp t
rdx_inc_0:
        add rdx,1
t:
        inc r8
        jmp main_loop
end_main_loop:
        mov rdi , print_format
        mov rsi, rcx
        mov rdx, rdx
        call printf
end:
        add rsp,1608
        ret