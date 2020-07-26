section .data
	const5 dq 5.0
	constn3 dq -3.0
    
section .text
global f1_0, f1_1, f2_0, f2_1, f3_0, f3_1
f1_0:
	push ebp
	mov ebp, esp
	;2^x + 1
	finit
	fld qword [ebp + 8]
	fld1
	fld qword [ebp + 8]
	fprem
	f2xm1
	faddp
	fscale
	fld1
	faddp

	leave
	ret

f1_1:
	push ebp
	mov ebp, esp
	;2^x * ln2
	finit
	fld qword [ebp + 8]
	fld1
	fld qword [ebp + 8]
	fprem
	f2xm1
	faddp
	fscale
	fldln2
	fmulp

	leave
	ret

f2_0:
	push ebp
	mov ebp, esp
	;x^5
	finit
	fld qword [ebp + 8]
	fld qword [ebp + 8]
	fmulp
	fld qword [ebp + 8]
	fmulp
	fld qword [ebp + 8]
	fmulp
	fld qword [ebp + 8]
	fmulp

	leave
	ret
	
f2_1:
	push ebp
	mov ebp, esp
	;5 * x^4
	finit
	fld qword [const5]
	fld qword [ebp + 8]
	fmulp
	fld qword [ebp + 8]
	fmulp
	fld qword [ebp + 8]
	fmulp
	fld qword [ebp + 8]
	fmulp
	
	leave
	ret
	
f3_0:
	push ebp
	mov ebp, esp
	;(1 - x) / 3 = (x - 1) / (-3)
	finit
	fld qword [ebp + 8]
	fld1
	fsubp
	fld qword [constn3]
	fdivp
	
	leave
	ret

f3_1:
	push ebp
	mov ebp, esp
	;-1 / 3
	finit
	fld1
	fld qword [constn3]
	fdivp
	
	leave
	ret
