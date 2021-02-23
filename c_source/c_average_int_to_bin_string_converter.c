#include <stdio.h>
#include <string.h>
#define CHAR_ARRY_MAX 80

/*
    Interesting notes:
        
        positiveDec + '0';  the + '0' is required to ensure it is recognised as a printable ASCII
        I had to reverse the Char Array
 
*/

void toBinary(int positiveDec, char *buf, int *i){

    if (positiveDec < 2){
        buf[*i] = positiveDec + '0';
        return;
    }
    
    int temp = ((positiveDec / 2  * 10 + positiveDec) % 2);
    buf[*i] = temp + '0';
    *i = *i + 1;

    printf("%d\t\t\t%d\t\t\t%d\n", positiveDec,  (positiveDec / 2  * 10 + positiveDec), temp);

    toBinary(positiveDec / 2, buf, i );
}

void unitTest(char *binStr, int rawInput){
    switch (rawInput) {
        case 10:
            if(strcmp(binStr, "0101") == 0){
                puts("[*]10 matched\n");
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


int main(void) {
    
    
    int input = 1000000;
    int index = 0;
    char binaryStr[CHAR_ARRY_MAX] = {};
    char revbinStr[CHAR_ARRY_MAX] = {};
    
    printf("[*]Inputted number:\t %d\nInput\t\tNo to Modulo\n", input);
    toBinary(input, binaryStr, &index);
    
    for (int i = 0; binaryStr[i] != '\0'; i++)
        revbinStr[i] = binaryStr[index - i];
    
    printf("[*]Original Bin String:\t%s\n", binaryStr);
    printf("[*]Length:\t%zu\n", strlen(binaryStr));
    printf("[*]Reversed Binary String:\t%s\n", revbinStr);
    unitTest(revbinStr, input);
    return 0;
}

