#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define CHAR_ARRY_MAX 80
#define INT_ARRY_MAX 6

void toBinary(int positiveDec, char *buf, int *i);
void unitTest(char *binStr, int rawInput);




int main(void) {
    int index = 0;
    int inputs[INT_ARRY_MAX] = { 10 , 15 , 16, 127, 255, 1000000 };
    size_t n = sizeof(inputs)/sizeof(inputs[INT_ARRY_MAX]);
    
    int i = 0;
    do {
        char *binaryStr = malloc(CHAR_ARRY_MAX);
        char *revbinStr = malloc(CHAR_ARRY_MAX);
        toBinary(inputs[i], binaryStr, &index);
        for (int i = 0; binaryStr[i] != '\0'; i++)
            revbinStr[i] = binaryStr[index - i];
        
        printf("[*]Input:\t%d\tBinary String:\t%s\n", inputs[i], revbinStr);
        unitTest(revbinStr, inputs[i]);

        binaryStr = NULL;
        revbinStr = NULL;
        free(binaryStr);
        free(revbinStr);
        index = 0;
        i++;
    } while (i < n);

    return 0;
}



void toBinary(int positiveDec, char *buf, int *i){

    if (positiveDec < 2){
        buf[*i] = positiveDec + '0';
        return;
    }
    
    int temp = ((positiveDec / 2  * 10 + positiveDec) % 2);
    buf[*i] = temp + '0';
    *i = *i + 1;

    toBinary(positiveDec / 2, buf, i );
}

void unitTest(char *binStr, int rawInput){
    switch (rawInput) {
        case 10:
            if(strcmp(binStr, "1010") == 0){
                puts("[*]10 matched\n");
                break;
            }
        case 15:
            if(strcmp(binStr, "1111") == 0){
                puts("[*]15 matched\n");
                break;
            }
        case 16:
            if(strcmp(binStr, "10000") == 0){
                puts("[*]16 matched\n");
                break;
            }
        case 127:
            if(strcmp(binStr, "1111111") == 0){
                puts("[*]127 matched\n");
                break;
            }
        case 255:
            if(strcmp(binStr, "11111111") == 0){
                puts("[*]255 matched\n");
                break;
            }
        case 1000000:
            if(strcmp(binStr, "11110100001001000000") == 0){
                puts("[*]1 million matched\n");
                break;
            }
            // failed string compares fallthrough, by design
        default:
            printf("[*]failed / not checked on %d\n\n",rawInput);
            break;
    }
}

