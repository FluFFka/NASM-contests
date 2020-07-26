%include "io.inc"

section .text
global CMAIN

solve:
    push ebp                ;prologue
    mov ebp, esp
    sub esp, 4              ;increase frame for even number
    
    GET_DEC 4, eax          ;input odd number
    test eax, -1            ;check 0
    jz .end
    PRINT_DEC 4, eax        ;ouput odd number
    PRINT_STRING " "
    
    GET_DEC 4, eax          ;input even number
    test eax, -1             ;check 0
    jz .end
    mov dword[ebp - 4], eax ;save even number
    call solve
    mov eax, dword[ebp - 4] ;output even number
    PRINT_DEC 4, eax
    PRINT_STRING " "
    
  .end:
    mov esp, ebp            ;epilogue
    pop ebp
    ret

CMAIN:
    call solve
    
    xor eax, eax
    ret
