**Задача 02-R4: Задача 4**
Дан код программы на языке Ассемблера. Вам необходимо восстановить семантику данной программы и выразить её в виде программы на языке Си.

                    %include "io.inc"

                    SECTION .data
                            mask    DD      0xffff, 0xff00ff, 0xf0f0f0f, 0x33333333, 0x55555555

                    SECTION .text
                    GLOBAL CMAIN
                    CMAIN:
                        GET_UDEC        4, EAX
                        MOV             EBX, mask
                        ADD             EBX, 16
                        MOV             ECX, 1
                    .L:
                        MOV             ESI, DWORD [EBX]
                        MOV             EDI, ESI
                        NOT             EDI
                        MOV             EDX, EAX
                        AND             EAX, ESI
                        AND             EDX, EDI
                        SHL             EAX, CL
                        SHR             EDX, CL
                        OR              EAX, EDX
                        SHL             ECX, 1
                        SUB             EBX, 4
                        CMP             EBX, mask - 4
                        JNE             .L
                    
                        PRINT_UDEC      4, EAX
                        NEWLINE
                        XOR             EAX, EAX
                        RET
                
На вход программе подается 32-битное беззнаковое число.

**Задача 02-R6: Перламутровая**
Дан код программы на языке Ассемблера. Вам необходимо восстановить семантику данной программы и выразить её в виде программы на языке Си.

                    %include "io.inc"

                    section .text
                    global CMAIN
                    CMAIN:
                        mov EBX, 0xffffffff
                    again:
                        GET_UDEC 4, EAX
                        cmp EAX, 0
                        jz exit
                        cmp EAX, EBX
                        ja again
                        mov EBX, EAX
                        jmp again
                    exit:   
                        PRINT_UDEC 4, EBX
                        xor eax, eax
                        ret

**Задача 03-R3: Задача 3**
Дан код программы на языке Ассемблера. Вам необходимо восстановить семантику данной программы и выразить её в виде программы на языке Си.

        			%include "io.inc"

                    SECTION .text
                    
        			GLOBAL CMAIN
                    CMAIN:
        			    SUB     	    ESP, 12
		        	    GET_DEC 	    4, [ESP]
        			    GET_DEC 	    4, [ESP + 4]
		        	    GET_DEC 	    4, [ESP + 8]
			            CALL    	    M
        			    ADD     	    ESP, 12
		        	    PRINT_DEC       4, EAX
			            NEWLINE
        			    XOR     	    EAX, EAX
		        	    RET

        			M:
		        	    MOV     	    EAX, DWORD [ESP + 4]
			            MOV     	    ECX, DWORD [ESP + 8]
        			    MOV     	    EDX, DWORD [ESP + 12]
		        	.1:
        			    CMP     	    EAX, ECX
		        	    JGE     	    .2
        			    XOR     	    EAX, ECX
		        	    XOR     	    ECX, EAX
			            XOR     	    EAX, ECX
        			.2:
		        	    CMP     	    EAX, EDX
        			    JG      	    .3
		        	    RET
        			.3:
		        	    XOR     	    EAX, EDX
			            XOR     	    EDX, EAX
        			    XOR     	    EAX, EDX
		        	    JMP     	    .1
На вход программе подаются 3 знаковых 32-битных числа.

**Задача 03-R4: Задача 4**
Дан код программы на языке Ассемблера. Вам необходимо восстановить семантику данной программы и выразить её в виде программы на языке Си.

                    %include 'io.inc'

                    %define BUF_SIZE 4095

                    section .bss
                            buf resb BUF_SIZE + 1

                            section .text

                    hash:
                            push    esi
                            xor     edx, edx
                            push    ebx
                            sub     esp, 1024
                            mov     ecx, dword [esp+1036]
                            mov     esi, esp
                       .L5:
                            mov     eax, edx
                            xor     ebx, ebx
                       .L4:
                            test    al, 1
                            je      .L2
                            shr     eax, 1
                            xor     eax, -306674912
                            jmp     .L3
                       .L2:
                            shr     eax, 1
                       .L3:
                            inc     ebx
                            cmp     ebx, 8
                            jne     .L4
                            mov     dword [esi+edx*4], eax
                            inc     edx
                            cmp     edx, 256
                            jne     .L5
                            or      eax, -1
                            jmp     .L6
                       .L7:
                            xor     edx, eax
                            inc     ecx
                            movzx   edx, dl
                            shr     eax, 8
                            xor     eax, dword [esp+edx*4]
                       .L6:
                            mov     dl, byte [ecx]
                            test    dl, dl
                            jne     .L7
                            add     esp, 1024
                            not     eax
                            pop     ebx
                            pop     esi
                            ret

                     global CMAIN
                     CMAIN:
                            push    ebp
                            mov     ebp, esp
                            sub     esp, 4

                            mov     byte [buf], 0
                            GET_STRING buf, BUF_SIZE
                            mov     byte [buf + BUF_SIZE], 0

                            mov     dword [esp], buf
                            call    hash

                            PRINT_HEX 4, eax
                            NEWLINE

                            xor     eax, eax
                            mov     esp, ebp
                            pop     ebp
                            ret
На стандарнтый вход программе подается 1 строка произвольной длины.
