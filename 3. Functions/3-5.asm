%include "io.inc"

section .text
global CMAIN

reverse:
    push ebp                ;prologue
    mov ebp, esp
    push esi                ;save esi
    
    
    mov edi, 0              ;result in edi
    mov ecx, 10             ;prepare divider and multiplier
    
    test eax, eax           ;check 0
    jz .end_cycle
  .cycle:
    ;edi * 10
    mov eax, edi            ;prepare number for multiply
    xor edx, edx
    mul ecx                 ;multiply
    mov edi, eax
    
    ;esi / 10 (and esi % 10)
    mov eax, esi            ;prepare number for division
    xor edx, edx
    div ecx                 ;division (ecx beacame 10 before cycle)
    
    mov esi, eax            ;update esi
    add edi, edx            ;update result
    test esi, esi           ;if (esi != 0) continue cycle
    jnz .cycle
  .end_cycle:
    mov eax, edi            ;put result in eax
    
    pop esi                 ;retrieve esi
    mov esp, ebp            ;epilogue
    pop ebp
    ret

CMAIN:
    GET_UDEC 4, esi         ;M
    GET_DEC 4, ecx          ;N (number of steps)
    
    test ecx, ecx
    jz .end_hypothesis      ;check 0
  .hypothesis:
    push ecx                ;save ecx
    call reverse
    pop ecx                 ;retrieve ecx
    add esi, eax            
    sub ecx, 1              ;N -= 1
    jnz .hypothesis         ;if (N != 0) continue cycle
  .end_hypothesis:
    
    call reverse
    cmp esi, eax            ;check palindrome
    jne .no                 ;if (esi != eax) print no
    
    PRINT_STRING "Yes"      ;else print yes
    NEWLINE
    PRINT_UDEC 4, esi
    jmp .end                ;jump to the end of program

  .no:
    PRINT_STRING "No"       ;print no
    
  .end:
    
    xor eax, eax
    ret
