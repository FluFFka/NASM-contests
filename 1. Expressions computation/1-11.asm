%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_CHAR al
    sub al, 64  ;letter to number
    neg al
    add al, 8   ;al = 8 - al
    GET_DEC 1, bl
    neg bl
    add bl, 8   ;bl = 8 - bl
    mul bl      ;al = al * bl
    mov cl, 2
    div cl      ;al = al / 2
    PRINT_DEC 1, al
    xor eax, eax
    ret
