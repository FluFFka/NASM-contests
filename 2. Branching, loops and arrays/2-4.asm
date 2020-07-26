%include "io.inc"

section .bss
    num resd 11

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, eax
    mov ecx, -1

tran:
    add ecx, 1
    mov ebx, 8
    mov edx, 0
    div ebx
    mov ebx, num
    mov dword[ebx + 4 * ecx], edx
    cmp eax, 0
    jne tran
    
output:
    mov eax, num
    mov eax, dword[eax + 4 * ecx]
    PRINT_DEC 4, eax
    sub ecx, 1
    jnc output
    
    xor eax, eax
    ret
