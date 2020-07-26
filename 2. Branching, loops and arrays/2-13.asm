%include "io.inc"

section .bss
    n resd 1
    arr resd 1000000
    k resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, n
    mov ebx, dword[n]
    sub ebx, 1  ;ebx is counter in input cycle
                ;ebx from n-1 to 0
                ;instart - cycle begin
                ;inend   - cycle end
    jc inend
instart:
    GET_UDEC 4, [arr + 4 * ebx] ;input array in reverse order
    mov eax, [arr + 4 * ebx]
    sub ebx, 1  ;ebx--
                ;repeat if ebx >=0
    jnc instart
inend:
    GET_UDEC 4, k
    
    mov ebx, dword[n]
    sub ebx, 1
    jc outend   ;if n==0, then end program
    
    mov eax, dword[k]
    cmp eax, 0  ;if k == 0, then output array (resout)
    jne continue
    mov ebx, dword[n]   ;ebx - cycle counter 
    sub ebx, 1  ;ebx from n-1 to 0
resout:
    PRINT_UDEC 4, [arr + 4 * ebx]
    PRINT_STRING " "
    sub ebx, 1  ;ebx--
    jnc resout  ;repeat if ebx >= 0
    jmp outend  ;end program after output cycle
    
continue:   ;if k != 0
    mov cl, byte[k] ;cl is number of bytes for shift
    mov edx, [arr + 4 * ebx]    ;edx is last element of array (ebx = n - 1)
                                ;but edx is first element of sequence
    shr edx, cl ;put k high bits of first element in edx
    neg cl
    add cl, 32  ;cl = 32-k
    mov eax, [arr]  ;eax is first element of array
                    ;but eax is last element of sequence
    shl eax, cl ;put 32-k low bits of last element in eax
    or eax, edx ;put new first number of sequence in eax
    PRINT_UDEC 4, eax   ;output this number
    PRINT_STRING " "
    
    sub ebx, 1
    jc outend   ;if n = 1, then end program
outstart:
    mov cl, byte[k] ;cl is number of bytes for shift
    mov edx, [arr + 4 * ebx]    ;edx is current element
    shr edx, cl ;put k high bits of current element in edx
    neg cl
    add cl, 32  ;cl = 32 - k
    mov eax, [arr + 4 * ebx + 4]    ;eax is previous element of sequence (next element of array)
    shl eax, cl ;put 32-k low bits of previous element in eax
    
    or eax, edx ;get new current number
    PRINT_UDEC 4, eax   ;output this number
    PRINT_STRING " "
    
    sub ebx, 1
    jnc outstart    ;if ebx >= 0 repeat
outend:
   
    xor eax, eax
    ret
