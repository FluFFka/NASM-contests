%include "io.inc"

section .bss
    a11 resd 1
    a12 resd 1
    a21 resd 1
    a22 resd 1
    b1 resd 1
    b2 resd 1
    x resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, a11
    GET_UDEC 4, a12
    GET_UDEC 4, a21
    GET_UDEC 4, a22
    GET_UDEC 4, b1
    GET_UDEC 4, b2
    
    ; x = (b1|b2)&((a12^b1)|(a22^b2))
    mov ebx, dword[b1]
    or ebx, dword[b2] ; ebx = b1|b2
    
    mov ecx, dword[a12]
    xor ecx, dword[b1]  ; ecx = a12^b1
    
    mov edx, dword[a22]
    xor edx, dword[b2]  ; edx = a22^b2
    
    or ecx, edx
    and ebx, ecx
    mov dword[x], ebx
    
    PRINT_UDEC 4, ebx
    PRINT_STRING " "
    
    ; y = (b1|b2)&((a11^b1)|(a21^b2))&x | (~x)&(b1|b2)
    mov ebx, dword[b1]
    or ebx, dword[b2] ; ebx = b1|b2
    mov eax, ebx ; ebx = b1|b2
    
    mov ecx, dword[a11]
    xor ecx, dword[b1]  ; ecx = a11^b1
    
    mov edx, dword[a21]
    xor edx, dword[b2]  ; edx = a21^b2
    
    or ecx, edx
    and ebx, ecx
    and ebx, dword[x] ; first part before "or"
    
    mov ecx, dword[x]
    not ecx
    and eax, ecx
    or ebx, eax
    
    PRINT_UDEC 4, ebx
    
    xor eax, eax
    ret
