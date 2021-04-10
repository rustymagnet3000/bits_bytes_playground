#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_ALPHABET 26
#define INT_ARRY_MAX 7
#define GREETING_LEN 6

void unitTest(const char *original_greeting, char *scrambled_greeting, unsigned int key);

unsigned int
modulo (unsigned int x, unsigned int y){
    if (x < y)
        return x;
    int m = modulo (x, 2 * y);
    if (m >= y)
        m = m - y;
    return m;
}

void
cipher (char *input_text, unsigned int shift_key) {
    for(int i = 0; input_text[i]!='\0'; i++){
        input_text[i] = ((input_text[i] - 'a') + shift_key);
        input_text[i] = modulo(input_text[i], MAX_ALPHABET) + 'a';
    }
}



int
main(void) {
    const unsigned int shift_keys[INT_ARRY_MAX] = { 78, 2, 3, 26, 52, 78, 104 };
    const char original_greeting[GREETING_LEN] = "hello";
    int i = 0;
    do {
        char *mutable_greeting = malloc(GREETING_LEN);
        strcpy(mutable_greeting, original_greeting);
        cipher(mutable_greeting, shift_keys[i]);
        unitTest(original_greeting, mutable_greeting, shift_keys[i]);
        i++;
    } while (i < INT_ARRY_MAX);

    return 0;
}


void
unitTest(const char *original_greeting, char *scrambled_greeting, unsigned int key){
    bool result = false;
    switch (key) {
        case 1:
            if(strcmp(scrambled_greeting, "ifmmp") == 0){
                result = true;
                break;
            }
        case 2:
            if(strcmp(scrambled_greeting, "jgnnq") == 0){
                result = true;
                break;
            }
        case 3:
            if(strcmp(scrambled_greeting, "khoor") == 0){
                result = true;
                break;
            }
        case 26:
            if(strcmp(scrambled_greeting, "hello") == 0){
                result = true;
                break;
            }
        case 52:
            if(strcmp(scrambled_greeting, "hello") == 0){
                result = true;
                break;
            }
        case 78:
            if(strcmp(scrambled_greeting, "hello") == 0){
                result = true;
                break;
            }
        case 104:
            if(strcmp(scrambled_greeting, "hello") == 0){
                result = true;
                break;
            }
        default:
            break;
    }
    printf ("[*]%s\t-> shift key:%d  \t\t-> %s\t\t%s\n", original_greeting, key, scrambled_greeting, result ? "passed" : "failed / not handled");
}

