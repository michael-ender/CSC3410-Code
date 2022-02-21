BITS 32

SECTION .data
	titleMsg DB 'The Swapping Program', 0xa
	lenTitleMsg EQU $-titleMsg
	userMsg DB 'Please enter a two character string:   '
	lenUserMsg EQU $-userMsg
	dispMsg DB 'The answer is:   '
	lenDispMsg EQU $-dispMsg
	endMsg DB ' ', 0xa
	lenEndMsg EQU $-endMsg

SECTION .bss
	two_char_string RESB 3
	two_char_string2 RESB 3

SECTION .text
	GLOBAL _start

_start:

	; Title
	mov eax, 4
	mov ebx, 1
	mov ecx, titleMsg
	mov edx, lenTitleMsg
	int 80h

	; Two Characters String
	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg
	mov edx, lenUserMsg
	int 80h
	; Read and store string
	mov eax, 3
	mov ebx, 2
	mov ecx, two_char_string
	mov edx, 2
	int 80h

	; Calculations
	mov al, [two_char_string]
	mov bl, [two_char_string+1]
	mov [two_char_string2], bl
	mov [two_char_string2+1], al

	; Print Reversed
	mov eax, 4
	mov ebx, 1
	mov ecx, dispMsg
	mov edx, lenDispMsg
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, two_char_string2
	mov edx, 2
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
