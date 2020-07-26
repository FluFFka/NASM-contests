%include "io.inc"

%define STR_SIZE 102

CEXTERN fgets
CEXTERN printf
CEXTERN get_stdin

section .rodata
    LC0 db "%s", 0
    LC1 db "%c", 0

section .bss
    s1 resb STR_SIZE
    s2 resb STR_SIZE
    
section .text
string_input:               ;void string_input(char *s)
                            ;input string in pointer s
    push ebp                        ;prologue
    mov ebp, esp
    sub esp, 24                     ;increase frame
    ;PRINT_DEC 4, esp
    ;NEWLINE
    
    mov ecx, dword [ebp + 8]
    call get_stdin                  ;prepare for string input
    mov dword [esp + 8], eax
    mov eax, ecx
    mov dword [esp], eax
    mov dword [esp + 4], STR_SIZE
    call fgets                      ;input string
    mov edx, -1
  .s_put:                           ;put 0 instead of '\n'
    add edx, 1
    cmp byte [eax + edx], 0         ;check end of string
    jne .s_put
    mov byte [eax + edx - 1], 0     ;change '\n'
    
    
    mov esp, ebp                    ;epilogue
    pop ebp
    ret

find_substring:             ;int find_substring(char *s1, char *s2)
                            ;function find s2 as substring in s1
                            ;if function found s2 as substring, 
                                ;function ouput answer in special format
                                ;and return 1
                            ;else return 0
    push ebp                        ;prologue
    mov ebp, esp
    push ebx                        ;save registers
    push edi
    push esi
    sub esp, 12                     ;increase and allign stack

    ;try to find second string in first string
    mov ecx, 0              ;displacement of index in first strings
    mov ebx, 0              
    mov edx, dword [ebp + 8]             ;edx = s1
    mov edi, dword [ebp + 12]            ;edi = s2
                            ;[edx + ecx] =?= [edi + ebx]
    push ecx                ;save displacement
  .L1:
    cmp byte [edi + ebx], 0 ;check end of second string
    je .out1                ;substring was found
    mov al, byte [edx + ecx]
    cmp al, 0               ;check end of first string
    je .end1                ;first string ended, substring wasn't found
    cmp al, byte [edi + ebx];check symbols in first and second string
    jne .update_L1          ;second string is not substring in 
                            ;first string with this displacement
    add ecx, 1              ;update indexes
    add ebx, 1
    jmp .L1
    
  .update_L1:
    pop ecx                 ;retrive displacement
    add ecx, 1              ;update displacement
    push ecx                ;save displacement
    xor ebx, ebx            ;update second string's index
    jmp .L1
    
    
  .out1:
    pop ecx                 ;retrive displacement

    mov edi, ecx            ;save start of substring in edi
    mov esi, ebx            ;save lenght of substring in esi
    
    mov eax, dword [ebp + 8]
    mov byte [eax + edi], 0 ;print prefix
    mov dword [esp + 4], eax
    mov dword [esp], LC0
    call printf
    
                            ;print bracket
    mov dword [esp + 4], 91 ;91 is '[' in ascii table
    mov dword [esp], LC1
    call printf
    
    mov eax, dword [ebp + 12]
    mov dword [esp + 4], eax ;print substring
    mov dword [esp], LC0
    call printf
    
                            ;print braket
    mov dword [esp + 4], 93 ;93 is ']' in ascii table
    mov dword [esp], LC1
    call printf
    
    
    mov edx, dword [ebp + 8]             ;print suffix
    add edx, edi
    add edx, esi
    mov dword [esp + 4], edx
    mov dword [esp], LC0
    call printf
    
    mov eax, 1              ;substring was found
    jmp .end                ;end function
    
  .end1:
    pop ecx
    mov eax, 0              ;substring wasn't found
    
  .end:
    
    add esp, 12                     ;retrieve esp
    pop esi                         ;retrieve registers
    pop edi
    pop ebx
    mov esp, ebp                    ;epilogue
    pop ebp
    ret
    

global CMAIN
CMAIN:
    sub esp, 12                     ;allign stack
    
                                    ;input strings
    mov dword [esp], s1
    call string_input
    
    mov dword [esp], s2
    call string_input
    
                                    ;try to find s2 in s1
    mov dword [esp], s1
    mov dword [esp + 4], s2
    call find_substring
    cmp eax, 1
    je .end                         ;check result of search

                                    ;try to find s1 in s2    
    mov dword [esp], s2
    mov dword [esp + 4], s1
    call find_substring
    cmp eax, 1
    je .end                         ;check result of search
    
    mov dword [esp + 4], s1         ;substring wasn't found
    mov dword [esp], LC0
    call printf                     ;output first string
    
  .end:
    
    add esp, 12                     ;retrieve esp
    xor eax, eax
    ret
