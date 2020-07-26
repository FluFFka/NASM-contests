%include "io.inc"

section .bss
    max_len resd 1
    curr_len resd 1
    last_number resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, ecx
    GET_DEC 4, ebx
    mov dword[last_number], ebx
    mov dword[curr_len], 1
    sub ecx, 1
    jecxz reset  ;not in the end of the cycle
                 ;because it's to long distance
cycle:
    GET_DEC 4, eax  ;current number
    mov ebx, dword[last_number]
    cmp eax, ebx
    jg continue     ;sequence continue
    mov ebx, dword[max_len]
    mov edx, dword[curr_len]
    cmp ebx, edx
    jg reset
    mov dword[max_len], edx ;update max_len
reset:
    mov dword[curr_len], 0
continue:
    add dword[curr_len], 1
    mov dword[last_number], eax
    sub ecx, 1
    cmp ecx, 0
    jg cycle

    mov ebx, dword[max_len]
    mov edx, dword[curr_len]
    cmp ebx, edx    ;update max_len
    jg output
    mov dword[max_len], edx
output:
    PRINT_DEC 4, max_len
    
    xor eax, eax
    ret
