%include "io.inc"

section .text
global CMAIN
CMAIN:

    GET_CHAR ah
    GET_DEC 1, al
    ;set x to ah:al
    
    GET_CHAR bh ;input space
    GET_CHAR bh
    GET_DEC 1, bl
    ;set y to bh:bl
    
    ;x1 and y1 in letters (abs(x1 - y1) won't change)
    
    sub ah, bh  ;ah = x1 - y1
    
    mov cl, ah
    sar cl, 7
    add ah, cl
    xor ah, cl  ;ah = abs(x1 - y1)
    
    sub al, bl  ;al = x2 - y2
    mov cl, al
    sar cl, 7
    add al, cl
    xor al, cl  ;al = abs(x2 - y2)
    
    add al, ah  ;sum of ways 
    PRINT_DEC 1, al
    
    
    xor eax, eax
    ret
