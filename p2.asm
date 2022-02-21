BITS 32

SECTION .data
	titleMsg DB 'The Multiplying Program', 0xa
	lenTitleMsg EQU $-titleMsg
	userMsg1 DB 'Please enter a single digit number:   '
	lenUserMsg1 EQU $-userMsg1 
	userMsg2 DB 'Please enter a single digit number:   '
	lenUserMsg2 EQU $-userMsg2
	dispMsg DB 'The answer is:  '
	lenDispMsg EQU $-dispMsg
	endMsg DB ' ', 0xa
	lenEndMsg EQU $-endMsg

SECTION .bss
	num1 RESB 2
	num2 RESB 2
	total RESB 5

section .text
	GLOBAL _start

_start:
	; Title
	mov eax, 4
	mov ebx, 1
	mov ecx, titleMsg
	mov edx, lenTitleMsg
	int 80h

	; First number
	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg1
	mov edx, lenUserMsg1
	int 80h
	; Read and store the user input
	mov eax, 3
	mov ebx, 2
	mov ecx, num1
	mov edx, 2
	int 80h

	; Second number
	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg2
	mov edx, lenUserMsg2
	int 80h
	; Read and store the user input
	mov eax, 3
	mov ebx, 2
	mov ecx, num2
	mov edx, 2
	int 80h	

	; Calculations (IMUL)
	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	imul eax, ebx
	add eax, '0'
	mov [total], eax

	; Output the message 'The answer is: '
	mov eax, 4
	mov ebx, 1
	mov ecx, dispMsg
	mov edx, lenDispMsg
	int 80h
	;Output the answer
	mov eax, 4
	mov ebx, 1
	mov ecx, total
	mov edx, 1
	int 80h

	; End Indent
	mov eax, 4
	mov ebx, 1
	mov ecx, endMsg
	mov edx, lenEndMsg
	int 80h

	;Exit code
	mov eax, 1
	mov ebx, 0
	int 80h
