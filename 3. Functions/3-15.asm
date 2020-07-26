%include "io.inc"

section .text
global CMAIN

check:
    push ebp                ;prologue
    mov ebp, esp
    push esi                ;save esi
    push edi                ;save edi
    push ebx                ;save ebx
    
    mov esi, dword[ebp + 8] ;put argument in esi
    mov edi, dword[ebp + 12];put argument in edi
    
    mov eax, esi            ;copy number in eax
    mov ebx, 0              ;len
    mov ecx, 0              ;curr sum
    
  .L1:
    add ebx, 1              ;update len
    xor edx, edx
    div edi
    add ecx, edx            ;update sum
    test eax, eax
    jnz .L1
    
    mov eax, ebx
    add eax, 1              ;add 1 to len for:
                            ;len = (len / 2) + (len % 2)
                            ;   equal
                            ;len = (len + 1) / 2
    xor edx, edx
    mov ebx, 2
    div ebx
    mov ebx, eax
    
    ;let sum1 is sum of numerals in first half of esi
    ;then sum - 2 * sum1 == 0 when and only when ticket is happy
    mov eax, esi            
  .L2:
    xor edx, edx
    div edi
    sub ecx, edx            ;sum -= 2 * numeral
    sub ecx, edx
    sub ebx, 1
    jnz .L2
    
    mov eax, ecx            ;if (ticket esi is happy) eax = 0
                            ;else eax != 0
    
    pop ebx                 ;retrieve ebx
    pop edi                 ;retrieve edi
    pop esi                 ;retrieve esi
    mov esp, ebp            ;epilogue
    pop ebp
    ret

CMAIN:
    GET_UDEC 4, esi         ;N
    GET_UDEC 4, edi         ;K
    
    sub esp, 12             ;increase frame
    
    ;while (ticket is not happy) esi += 1
  .broot:
    mov dword[esp], esi     ;put arguments for function
    mov dword[esp + 4], edi
    call check
    test eax, eax           ;check ticket
    jz .end
    add esi, 1              ;increase value if ticket is not happy
    jmp .broot
    
    ;this cycle will not do     more then 2*sqrt(N) iterations
    ;because sqrt(N) is size of second half of number N
    ;we can broot all variantions of this half and get all values of this sums for sqrt(N) iterations
    ;and find sum which will be same as first half of N
    ;Or increase first half of number for less then sqrt(N) iterations we will find number (broot all variations of second half)
    
  .end:
    PRINT_UDEC 4, esi
    add esp, 12             ;retrieve esp
    
    xor eax, eax
    ret
