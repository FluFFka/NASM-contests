%include "io.inc"

section .bss
   x1 resd 1
   y1 resd 1
   x2 resd 1
   y2 resd 1
   x3 resd 1
   y3 resd 1 

section .text
global CMAIN
CMAIN:
    GET_DEC 4, x1
    GET_DEC 4, y1
    GET_DEC 4, x2
    GET_DEC 4, y2
    GET_DEC 4, x3
    GET_DEC 4, y3
    
    mov eax, dword[x1]
    sub eax, dword[x2]
    mov dword[x2], eax
    mov eax, dword[y1]
    sub eax, dword[y2]
    mov dword[y2], eax  ;(x2, y2) - vector - triangle's side
    
    mov eax, dword[x1]
    sub eax, dword[x3]
    mov dword[x3], eax
    mov eax, dword[y1]
    sub eax, dword[y3]
    mov dword[y3], eax  ;(x3, y3) - vector - triangle's side
    
    ;S = abs(x2*y3 - x3*y2)
    ;S_tr = S / 2
    mov eax, dword[x2]
    cdq
    imul dword[y3]
    mov ebx, eax
    mov eax, dword[x3]
    cdq
    imul dword[y2]
    sub eax, ebx    ;eax = x2*y3 - x3*y2
    
    mov ebx, eax
    sar ebx, 31
    add eax, ebx
    xor eax, ebx    ;eax = abs(x2*y3 - x3*y2)
    
    mov ecx, 2
    cdq
    div ecx     ;eax = [S/2]
    PRINT_DEC 4, eax
    
    ;edx = S % 2 (1 or 0)
    mov bl, " " ;' ' - 32(ascii)
    mov eax, edx
    mov cl, 14  ;'.' - 46(ascii)
    mul cl
    add bl, al
    PRINT_CHAR bl
    mov bl, " " ;' ' - 32(ascii)
    mov eax, edx
    mov cl, 21  ;'5' - 53(ascii)
    mul cl
    add bl, al
    PRINT_CHAR bl

    xor eax, eax
    ret
