%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_DEC 4, eax
    mov ebx, eax
    sar ebx, 31
    add eax, ebx
    xor eax, ebx
    PRINT_DEC 4, eax
    xor eax, eax
    ret
