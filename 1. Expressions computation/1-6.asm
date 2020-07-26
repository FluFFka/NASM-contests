%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, eax
    GET_DEC 1, cl
    neg cl
    add cl, 32
    shl eax, cl
    shr eax, cl
    PRINT_DEC 4, eax
    xor eax, eax
    ret
