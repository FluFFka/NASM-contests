%include "io.inc"

CEXTERN malloc
CEXTERN realloc
CEXTERN free
CEXTERN scanf
CEXTERN printf

section .rodata
    LC0 db "%d", 0

section .text
global CMAIN
CMAIN:
    sub esp, 12                     ;allign stack
    
    mov esi, 0                      ;last index of array
    mov ebx, 1                      ;size of memory which was 
                                    ; allocated for array
                                    ; (in ints, i.e. 4*ebx is size in bites)
    mov dword [esp], 4
    call malloc
    mov edi, eax                    ;edi is array pointer
    
  .inp_begin:
    mov dword [esp], LC0            ;put arguments for input
    lea edx, [edi + 4 * esi]
    mov dword [esp + 4], edx
    call scanf
    cmp dword [edi + 4 * esi], 0    ;check 0
    je .inp_end                     ;end cycle if 0
    inc esi                         ;index++
    cmp esi, ebx                    ;check end of allocated memory
    jne .inp_begin
    shl ebx, 1                      ;increase memory for array
    mov dword [esp], edi            ;put arguments for realloc
    lea edx, [4 * ebx]
    mov dword [esp + 4], edx
    call realloc                    ;increase memory for array
    mov edi, eax                    ;save pointer in edi
    jmp .inp_begin                  ;repeat
  .inp_end:
    xor eax, eax                    ;eax is last number in array
    xor ebx, ebx                    ;ebx is answer
    sub esi, 1
    jc .end                         ;check zero
    mov eax, [edi + 4 * esi]        ;put last number in eax
  .L1:
    sub esi, 1                      ;esi-- and check esi >= 0
    jc .end
    cmp eax, [edi + 4 * esi]        ;check eax > curr_number
    jbe .L1
    inc ebx                         ;answer++
    jmp .L1
  .end:
    mov dword [esp], edi            ;put argument for free
    call free                       ;free allocated memory
    
    mov dword [esp], LC0            ;put argument for print
    mov dword [esp + 4], ebx
    call printf                     ;print answer
    
    add esp, 12                     ;retrieve esp
    xor eax, eax
    ret
