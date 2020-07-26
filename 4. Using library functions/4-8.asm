%include "io.inc"

CEXTERN fopen
CEXTERN fclose
CEXTERN fscanf
CEXTERN fprintf
CEXTERN qsort

section .rodata
    LC0 db "input.txt", 0
    LC1 db "r", 0
    LC2 db "output.txt", 0
    LC3 db "w", 0
    LC4 db "%d", 0
    LC5 db "%d ", 0

section .bss
    a resd 1000

section .text

compare_func:
    push ebp                        ;prologue
    mov ebp, esp
    
    mov eax, dword [ebp + 8]
    mov eax, dword [eax]
    mov ecx, dword [ebp + 12]
    mov ecx, dword [ecx]
    cmp eax, ecx
    jg .great
    je .equal
    mov eax, -1
    jmp .ex
  .great:
    mov eax, 1
    jmp .ex
  .equal:
    mov eax, 0
  .ex:
    
    mov esp, ebp                    ;epilogue
    pop ebp
    ret

global CMAIN
CMAIN:
    sub esp, 28                     ;allign stack
    
    xor esi, esi                    ;esi is index of last element
    
    mov dword [esp], LC0            ;open input.txt
    mov dword [esp + 4], LC1
    call fopen
    mov edi, eax                    ;save file in edi
    
  .inp_begin:
    mov dword [esp], edi            ;input element
    mov dword [esp + 4], LC4
    lea edx, [a + 4 * esi]
    mov dword [esp + 8], edx
    call fscanf
    inc esi                         ;index++
    cmp eax, 1                      ;check end of input
    je .inp_begin

    mov dword [esp], edi            ;close input.txt
    call fclose

    dec esi                         ;esi is size of array
    
    mov dword [esp], a              ;sort array
    mov dword [esp + 4], esi
    mov dword [esp + 8], 4
    mov dword [esp + 12], compare_func
    call qsort
    
    mov dword [esp], LC2            ;open output.txt
    mov dword [esp + 4], LC3
    call fopen
    mov edi, eax                    ;save file in edi
    xor ebx, ebx                    ;ebx is index
  .out_begin:
    cmp ebx, esi
    je .out_end
    mov dword [esp], edi
    mov dword [esp + 4], LC5
    mov edx, dword [a + 4 * ebx]
    mov dword [esp + 8], edx
    call fprintf
    inc ebx
    jmp .out_begin
    
  .out_end:
    mov dword [esp], edi
    call fclose
    
    
    add esp, 28                     ;retrieve esp
    xor eax, eax
    ret
