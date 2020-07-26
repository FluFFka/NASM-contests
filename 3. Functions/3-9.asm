%include "io.inc"

section .text
global CMAIN

check:
    push ebp                ;prologue
    mov ebp, esp
    push esi                ;save esi
    push ebx                ;save ebx
                            
                            ;esi is curr number
    mov ebx, 0              ;ebx is sum of dividers
    mov edi, esi            ;edi is curr divider
  .cycle:
    sub edi, 1
    jz .end                 ;end cycle if edi is 0
    mov eax, esi            ;prepare for division
    xor edx, edx
    div edi                 ;esi / edi and esi % edi
    
    test edx, edx           ;if esi % edi == 0: update ebx
    jnz .cycle
    add ebx, edi
    jmp .cycle
    
  .end:
    mov eax, 1              ;if ebx < esi: eax = 1 (esi is special number)
    cmp ebx, esi            ;if ebx >= esi: eax = 0 (esi is not special number)
    jl .skip
    mov eax, 0
  .skip:
    
    pop ebx                 ;retrieve ebx
    pop esi                 ;retrieve esi
    mov esp, ebp            ;epilogue
    pop ebp
    ret

CMAIN:
    GET_DEC 4, ebx
    
    mov esi, 0
  .broot:
    add esi, 1
    call check
    sub ebx, eax            ;ebx -= 1 if esi is special number
                            ;ebx -= 0 if esi is not special number
    jnz .broot
    
    PRINT_DEC 4, esi        ;print last special number
    xor eax, eax
    ret
