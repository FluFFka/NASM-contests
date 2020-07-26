%include "io.inc"

section .bss
   n resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, n
    mov ebx, 1
    
cycle:
    add ebx, 1
    mov edx, 0
    mov eax, dword[n]
    cmp ebx, 100000
    jge change
    div ebx
    test edx, edx
    jnz cycle
    jz END
change:
    mov ebx, dword[n]
END:
    mov eax, dword[n]
    div ebx
    PRINT_DEC 4, eax
    xor eax, eax
    ret
