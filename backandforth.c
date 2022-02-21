#include <stdio.h>
#include <string.h>

//asm code
int addstr(char *a, char *b);                                           //prototype that calls addstr asm function
int is_palindrome(char *s, int l);                                      //prototype that calls is_palindrome asm function
int factstr(char *s);                                                   //prototype that calls is_palindrome asm function
void palindrome_check();                                                //prototype that calls palindrome_check asm function

//c code
int atoi(const char *nptr);                                             //changes strings into integers

int fact(int n) {                                                       //function that get the factorial of number
    int total = 1;
    for (int i = 1; i <= n; i++) {
        total = total * i;
    }
    return total;
}

int palindrome(char *s) {                                               //function that checks if a string is a palindrome
    int i, j;
    int max = strlen(s) - 1;                                            //gets length of string (has to be -1 so it stayed in scope)
    int pally;
    printf("\nYou entered %s\n", s);
    for (i = 0, j = max - 1; i < max/2; i++, j--) {
        if (s[i] != s[j]) {
            pally = 0;                                                  //if pally is 0, asm prints that it is not a palindrome
            return pally;
        }
    }
    pally = 1;                                                          //if pally is 1, asm prints that it is a palindrome
    return pally;
}

int main () {
    int answer;                                                         //user answer for the switch statement

    char a[20];                                                         //a and b are the input numbers for the addition function
    char b[20];
    int result;                                                         //a + b gets stored here

    char input[100];                                                    //variable for palindrome input
    int palindrome;                                                     //where the number is stored for palindrome (1 or 2) #2 function not #4

    char stuff[100];                                                    //variable for user input in factorial function
    int strResult;                                                      //where answer is stored for the factorial function

    while (answer != 5) {
        printf("1) Add two numbers\n2) Check if palindrome(in ASM)\n3) Factorial of number\n4) Check if palindrome(in C)\n5) Exit\nEnter in a number 1-5: ");
        scanf("%d", &answer);
        switch (answer) {
            case 1:             
                //adding
                printf("\nAdding!\nEnter a number\n");
                scanf("%s", a);
                scanf("%s", b);
                result = addstr(a, b);                                  //result from addstr gets stored in result
                printf("\nThe result is %d\n\n", result);
                break;
            case 2:
                //palindrome check (in ASM)
                printf("\nPalindrome check (in ASM)!\nEnter in a string: ");
                scanf("%s", input);
                int len = strlen(input);
                palindrome = is_palindrome(input,len);                  //result for is_palindrome gets stored in palindrome
                if (palindrome == 0) {
                    printf("\n%s is not a palindrome\n\n", input);
                }
                else {
                    printf("\n%s is a palindrome\n\n", input);
                }
                break;
            case 3:
                //factorial
                printf("\nPrinting a factorial!\nEnter in a number: ");
                scanf("%s", stuff);
                strResult = factstr(stuff);                             //result for factstr gets stored in strResult
                printf("\nThe factorial of the number is %i\n\n", strResult);
                break;
            case 4:                                                     //working but runs into a segmentation error
                //palindrome check (in C)
                palindrome_check();                                     //calls the palindrome_check in asm and everything gets worked on in asm
                break;
            case 5:
                printf("Goodbye!\n");
                break;
            default:
                printf("\nINVALID ARGUMENT\n\n");
                break;
        }      
    }
    return 0;        
}