%include "io.inc"

section .bss
    n resd 1
    x resd 12
    y resd 12

section .text
global CMAIN

lcm:
    push ebp                ;prologue
    mov ebp, esp
    push ebx                ;save registers
    push esi
    push edi
    
    mov eax, dword[ebp + 16];get variables
    mov ecx, dword[ebp + 12]
    
    ;Euclid's algorithm
  .gcd:
    xor edx, edx            ;prepare for division
    div ecx
    xchg ecx, edx           ;take a % b
    mov eax, edx            ;a is b
    test ecx, ecx           ;check 0
    jnz .gcd
    ;eax is gcd(a, b)
    
    mov ecx, eax        
    mov eax, dword[ebp + 16]
    xor edx, edx
    div ecx                 ;lcm = a / gcd(a, b) * b
    mul dword[ebp + 12]
    
    pop edi                 ;retrieve registers
    pop esi
    pop edx
    mov esp, ebp            ;epilogue
    pop ebp
    ret

CMAIN:
    GET_DEC 4, n            ;N
    mov ecx, dword[n]       ;ecx is counter for cycle
    sub ecx, 1
    mov ebx, x              ;x[i] = dwrod[ebx + 4 * ecx]
                            ;x and y arrays will be reverse ordered
    
    GET_DEC 4, edi          ;input x
    mov dword[ebx + 4 * ecx], edi
    GET_DEC 4, edi          ;input y
    mov ebx, y
    mov dword[ebx + 4 * ecx], edi
    
    mov esi, edi            ;esi - denominator
    
    sub esp, 8              ;prepare for function
   
    sub ecx, 1              ;if (ecx == 0) to end of cycle
    jc .end_lcm_cycle       ;  (ecx == 0 equivalent n == 1)
    
  .lcm_cycle:
    
    mov ebx, x
    GET_DEC 4, edi          ;input x
    mov dword[ebx + 4 * ecx], edi
    GET_DEC 4, edi          ;input y
    mov ebx, y
    mov dword[ebx + 4 * ecx], edi
    
    mov dword[esp], esi     ;put arguments for function
    mov dword[esp + 4], edi
    push ecx                ;save ecx
    call lcm
    pop ecx                 ;retrieve ecx
    mov esi, eax            ;update esi
    sub ecx, 1              ;if (ecx >= 0) continue cycle
    jnc .lcm_cycle
  .end_lcm_cycle:

    add esp, 8              ;retrieve esp
    
    mov edi, 0              ;edi is numenator 
    
    mov ecx, dword[n]       ;ecx is counter for cycle
    sub ecx, 1
  .numen_comp:
    mov ebx, y
    mov eax, esi
    xor edx, edx
    mov ebx, dword[ebx + 4 * ecx]   ;esi / y[ecx]
    div ebx                 ;eax contents number which:
                            ;x[i] / y[i] == x[i] * eax / esi
    mov ebx, x
    mov ebx, dword[ebx + 4 * ecx]
    mul ebx                 ;eax is new x[i] for fraction with esi
    add edi, eax            ;update edi
    
    sub ecx, 1              ;if (ecx >= 0) continue cycle
    jnc .numen_comp
    
    ;answer is edi/esi
    ;but it should be proper fraction
    
    ;Euclid's algorithm 
    mov eax, esi
    mov ecx, edi
  .proper:
    xor edx, edx
    div ecx                 ;eax / ecx
    xchg ecx, edx           ;ecx = eax % ecx
    mov eax, edx            ;eax = old ecx
    test ecx, ecx           ;while (ecx != 0) continue cycle
    jnz .proper
    
    mov ebx, eax            ;copy gcd in ebx
    
    ;make edi/esi proper fraction
    mov eax, edi            ;edi / gcd(esi, edi)
    xor edx, edx
    div ebx
    PRINT_UDEC 4, eax
    PRINT_STRING " "
    mov eax, esi            ;esi / gcd(esi, edi)
    xor edx, edx
    div ebx
    PRINT_UDEC 4, eax
    
    xor eax, eax
    ret
