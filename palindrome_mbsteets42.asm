BITS 32

SECTION .data
    titleMsg DB 'Is the word a palindrome?', 0xa
    lenTitleMsg EQU $-titleMsg 
    userMsg DD 'Enter in a message: '
    lenUserMsg EQU $-userMsg
    msg1 DB "Is palindrome", 0xa
    lenMsg1 EQU $-msg1
    msg2 DB "Is not palindrome", 0xa
    lenMsg2 EQU $-msg2
    testMsg DB "hello", 0
    lenTestMsg EQU $-testMsg 

SECTION .bss
    response RESB 100
    length RESB 100

section .text   
    GLOBAL _start 

_start: 

    ;Title 
    mov eax, 4
    mov ebx, 1
    mov ecx, titleMsg
    mov edx, lenTitleMsg
    int 80h

    ; User Message (Ask for Input)
    mov eax, 4
    mov ebx, 1
    mov ecx, userMsg
    mov edx, lenUserMsg
    int 80h

    ; Read in Message
    mov eax, 3
    mov ebx, 2
    mov ecx, response
    mov edx, 100
    int 80h   

    check:

        cmp byte [response], 0xa           ;compares input to newline 
        je exit

        dec eax
        push eax                            ;length
        mov eax, ecx                        ;input
        push eax

        mov ebp, esp
        push ebp

        mov edx, [eax+8]                    ;string address
        mov ebx, [eax+12]                   ;length
        mov ecx, 0                          ;counter
        dec edx

        call check1

	    jmp check

    check1:                             ;for loop
        cmp ecx, edx                    ;ERROR AT THIS PART
        jge is_palindrome               ;if eax is greater or equal to half the length of length, jump to is_palindrome
        mov al, [ebx+ecx]               ;first letter of response (increases)
        mov ah, [ebx+edx]               ;last letter of response (decreases)
        inc ecx                         ;increases from 0
        dec edx                         ;decreases from length
        cmp al, ah                      
        je check1                       ;if the letters are equal, go back to check1
        jne not_palindrome              ;if they are not equal, jump to not_palindrome

    is_palindrome:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg1
        mov edx, lenMsg1
        int 80h

        ; User Message (Ask for Input)
        mov eax, 4
        mov ebx, 1
        mov ecx, userMsg
        mov edx, lenUserMsg
        int 80h

        ; Read in Message
        mov eax, 3
        mov ebx, 2
        mov ecx, response
        mov edx, 100
        int 80h

        jmp check

    not_palindrome:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, lenMsg2
        int 80h

        ; User Message (Ask for Input)
        mov eax, 4
        mov ebx, 1
        mov ecx, userMsg
        mov edx, lenUserMsg
        int 80h

        ; Read in Message
        mov eax, 3
        mov ebx, 2
        mov ecx, response
        mov edx, 100
        int 80h

        jmp check

    exit:   
        mov eax, 1
        mov ebx, 0
        int 80h

    ; EXIT PROGRAM
    mov eax, 1
    mov ebx, 0
    int 80h
