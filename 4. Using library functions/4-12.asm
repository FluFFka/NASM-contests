%include "io.inc"

CEXTERN fopen
CEXTERN fclose
CEXTERN fread
CEXTERN printf

section .rodata
    LC0 db "input.bin", 0
    LC1 db "rb", 0
    LC2 db "%d ", 0

section .bss
    a resd 30000                    ;array of input
    mark resb 10000                 ;marked vertexes

section .text
dfs:                    ;void dfs (int root, int *info) where
                        ;   info is input array
                        ;dfs is recursive function that prints
                        ;vertex ordered in dfs
    push ebp                        ;prologue
    mov ebp, esp
    sub esp, 8                      ;increase frame
    
    mov eax, dword [ebp + 8]        ;index of vertex
    mov edx, dword [ebp + 12]       ;input array
    
    mov dword [esp], LC2            ;put arguments for print
    mov ecx, [edx + 4 * eax]
    mov dword [esp + 4], ecx
    call printf                     ;print vertex
    
    mov eax, dword [ebp + 8]        ;retrieve arguments
    mov edx, dword [ebp + 12]
    mov ecx, dword [edx + 4 * eax + 4]
    cmp ecx, -1                     ;check first child
    je .skip1
    shr ecx, 2                      ;calculate index of child
    mov dword [esp], ecx
    mov dword [esp + 4], edx
    call dfs                        ;call dfs from child
  .skip1:
    mov eax, dword [ebp + 8]        ;retrieve arguments
    mov edx, dword [ebp + 12]
    mov ecx, dword [edx + 4 * eax + 8]
    cmp ecx, -1                     ;check second child
    je .skip2
    shr ecx, 2                      ;calculate index of child
    mov dword [esp], ecx
    mov dword [esp + 4], edx
    call dfs                        ;call dfs from child
  .skip2:
  
    add esp, 8                      ;retrieve frame
    mov esp, ebp                    ;epilogue
    pop ebp
    ret
    
    

global CMAIN
CMAIN:
    sub esp, 28                     ;allign stack
    
    mov dword [esp], LC0            ;open input.bin
    mov dword [esp + 4], LC1
    call fopen
    mov edi, eax                    ;save file in edi
    
    
    mov dword [esp], a              ;read input.bin
    mov dword [esp + 4], 4
    mov dword [esp + 8], 30000
    mov dword [esp + 12], edi       ;put input.bin in edi
    call fread
    xor edx, edx                    ;calculate number of vertexes
    mov ecx, 3
    div ecx
    mov ebx, eax                    ;save number of vertexes
    mov dword [esp], edi
    call fclose
    
    ;mark vertexes which is child
    xor ecx, ecx                    ;index
  .marking:
    lea esi, [2 * ecx + ecx]        ;esi is index of vertex in input array
    mov edi, dword [a + 4 * esi + 4]
    cmp edi, -1                     ;check first child
    je .cont1
    mov eax, edi                    ;mark first child
    xor edx, edx
    mov esi, 12
    div esi                         ;calculate index of vertex in mark array
    mov byte[mark + eax], 1         ;mark[edi / 12] = 1
  .cont1:
    lea esi, [2 * ecx + ecx]        ;esi is index of vertex in input array
    mov edi, dword [a + 4 * esi + 8]
    cmp edi, -1                     ;check second child
    je .cont2
    mov eax, edi                    ;mark second child
    xor edx, edx
    mov esi, 12
    div esi                         ;calculate index of vertex in mark array
    mov byte[mark + eax], 1         ;mark[edi / 12] = 1
  .cont2:
    inc ecx                         ;increse index
    cmp ecx, ebx                    ;check end of array
    jne .marking

    ;find not marked vertex - this vertex is root (because it's not child)
        ;and start dfs from this vertex to output answer
    mov ecx, -1
  .find_for_dfs:
    inc ecx
    cmp byte [mark + ecx], 0
    jne .find_for_dfs
    mov dword [esp + 4], a          ;put array as second argument
    lea ecx, [2 * ecx + ecx]
    mov dword [esp], ecx            ;put argument of root in input array as first argument
    call dfs
    
    add esp, 28                     ;retrieve esp
    xor eax, eax
    ret
