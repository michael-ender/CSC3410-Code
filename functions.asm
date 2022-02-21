BITS 32
GLOBAL addstr                                               ;addstr function called from c
GLOBAL is_palindrome                                        ;is_palindrome function called from c
GLOBAL factstr                                              ;factstr function called from c
GLOBAL palindrome_check                                     ;palindrome_check called form c

extern atoi                                                 ;atoi c function called from asm
extern fact                                                 ;fact c function called from asm
extern palindrome                                           ;palindrome c function called from asm

SECTION .data
    userInput DB 'Enter in a string: ', 0xa
    lenUserInput EQU $-userInput 
    pallyd DB 'Is a palindrome', 0xa
    lenPallyD EQU $-pallyd
    noPallyd DB 'Is not a plaindrome', 0xa
    lenNoPallyD EQU $-noPallyd

SECTION .bss
    response2: resb 100

SECTION .text

addstr:
    push ebp                                                ;beginning push ebp from every c function
    mov ebp, esp                                            ;craetes a backup pointer for esp

    push ebx                                                ;pushes ebx onto stack

    mov eax, [ebp+8]                                        ;calls first input from c
    push eax                                                ;pushes ont stack to go into atoi
    call atoi                                               ;calls atoi to change string to integer
    add esp, 4                                              ;pops eax from stack
    mov ebx, eax
    mov eax, [ebp+12]                                       ;calls second input from c
    push eax                                                ;same as before with string to int
    call atoi
    add esp, 4
    add eax, ebx                                            ;adds answers together into eax which is going to be returned to c

    pop ebx                                                 ;pop everything from stack
    pop ebp
    ret

is_palindrome:                                              ;function to check if palindrome from ASM
    push ebp
    mov ebp, esp
    
    push ebx
    push edx
    push ecx

    mov ebx, [ebp+8]                                        ;input
    mov edx, [ebp+12]                                       ;length
    mov ecx, 0                                              ;initial length

    jmp pal_check

pal_check:
    mov al, BYTE[ebx+edx-1]                                 ;moves last letter of word into al
    mov ah, BYTE[ebx+ecx]                                   ;moves first letter of word into ah
    cmp al, ah                                              ;compares al and ah
    jne not_palindrome                                      ;if al and ah are not equal, it jumps to not_palindrome

    dec edx                                                 ;decreases edx by 1 if first jump is not met
    inc ecx                                                 ;increases ecx
    cmp ecx, edx                                            ;compares ecx and edx
    jge is_a_palindrome                                     ;if ecx is greater than or equal to edx, jump to is_palindrome

    jmp pal_check                                           ;unconditional jump if no conditional jumps are met (a for loop)

not_palindrome:

    mov eax, 0                                              ;moves 0 to eax which is sent to C

    pop ecx                                                 ;pop everything off stack
    pop edx
    pop ebx
    pop ebp
    ret

is_a_palindrome:

    mov eax, 1                                              ;moves 1 to eax which is sent to C

    pop ecx                                                 ;pop everything off stack
    pop edx
    pop ebx
    pop ebp
    ret

factstr:                                                    ;function to get a factorial of a number
    push ebp                                                ;beginning pushes for pointers
    mov ebp, esp                                    
    
    push ebx

    mov eax, [ebp+8]                                        ;moves number input from C into eax
    push eax                                                ;pushes eax into atoi to get an integer from a string
    call atoi                                               ;makes the string an integer
    add esp, 4                                              ;pop off stack
    push eax                                                ;pushes eax into fact to get a factorial
    call fact                                               ;calls fact function in call
    add esp, 4                                              ;pops off stack

    pop ebx                                                 ;popping all off stack
    pop ebp
    ret

palindrome_check:                                           ;checks if user input from ASM is a palindrome or not
    push eax
    push ebx
    push ecx
    push edx

    mov eax, 4                                              ;this block tells user to input a string
    mov ebx, 1
    mov ecx, userInput
    mov edx, lenUserInput
    int 80h

    mov eax, 3                                              ;this block reads user input
    mov ebx, 0
    mov ecx, response2
    mov edx, 100
    int 80h

    push ecx                                                ;pushes response2 onto stack and moves it into palindrome in C
    call palindrome                                         ;calls palindrome function in C
    add esp, 4                                              ;pops ecx off stack

    cmp eax, 0                                              ;compares eax to 0
    je non_pally                                            ;if eax is equal to 0, jump to non_pally
    jg pally                                                ;if eax is greater than 0, jump to pally

pally:                                                      ;function that prints out that the word is a palindrome

    mov eax, 4
    mov ebx, 1
    mov ecx, pallyd
    mov edx, lenPallyD
    int 80h

    pop edx
    pop ecx
    pop ebx
    pop eax

    ret

non_pally:                                                  ;function that prints out the word is not a palindrome

    mov eax, 4
    mov ebx, 1
    mov ecx, noPallyd
    mov edx, lenNoPallyD
    int 80h

    pop edx
    pop ecx
    pop ebx
    pop eax

    ret