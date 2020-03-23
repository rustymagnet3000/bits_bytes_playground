#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define CHAR_ARRY_MAX 64
#define INT_ARRY_MAX 11
#define NR_CHECK_VALUES (sizeof(array_binary_values)/sizeof(array_binary_values[0]))

/*
The code should cope with the largest possible 64-bit number:

   unsigned __int64     8     unsigned long long     0 to 18,446,744,073,709,551,615

   64 bits, all set to 1:
   1111111111111111111111111111111111111111111111111111111111111111

Moved to calloc() to avoid spurious issues when memory is not empty.
*/

typedef struct {
    int decimal;
    char *bin_string;
} bin_dec_keypair;

void to_binary(unsigned long long ullDecimal, char *buf, int *i);
void verify_result(bin_dec_keypair *input_keypair);


static bin_dec_keypair array_binary_values[] = {
            { 10, "1010" },
            { 15, "1111" },
            { 255, "11111111" },
            { 127, "1111111" },
            { 1223, "10011000111" },       // prime
            { 11483, "10110011011011" },      // prime
            { 7919, "1111011101111" },       // prime
            { 100000, "11110100001001000000" },
            { 16, "10000" }
};

int main(void) {
    int index = 0;

    unsigned long long inputs[INT_ARRY_MAX] = { 7919, 11483, 8,9, 10 , 15 , 16, 127, 255, 1223, 1000000 };
    
    size_t n = sizeof(inputs)/sizeof(inputs[INT_ARRY_MAX]);

    int i = 0;
    do {
        char *binaryStr = calloc(CHAR_ARRY_MAX, sizeof(char));
        char *revbinStr = calloc(CHAR_ARRY_MAX, sizeof(char));
        to_binary(inputs[i], binaryStr, &index);
        for (int i = 0; binaryStr[i] != '\0'; i++)
            revbinStr[i] = binaryStr[index - i];

        printf("[*]Input:\t%llu\tBinary String:\t%s\n", inputs[i], revbinStr);
        bin_dec_keypair struct_to_verify = {.decimal = inputs[i], .bin_string = revbinStr};
        verify_result(&struct_to_verify);

        binaryStr = NULL;
        revbinStr = NULL;
        free(binaryStr);
        free(revbinStr);
        index = 0;
        i++;
    } while (i < n);

    return EXIT_SUCCESS;
}

void to_binary(unsigned long long ullDecimal, char *buf, int *i){

    if (ullDecimal < 2){
        buf[*i] = ullDecimal + '0';
        return;
    }

    int temp = ((ullDecimal / 2  * 10 + ullDecimal) % 2);
    buf[*i] = temp + '0';
    *i = *i + 1;

    to_binary(ullDecimal / 2, buf, i );
}

int compar(const void *input, const void *actual)
{
    return strcmp(((bin_dec_keypair *)input)->bin_string, ((bin_dec_keypair *)actual)->bin_string);
}

void verify_result(bin_dec_keypair *input_keypair){
    
    bin_dec_keypair *res;
    qsort(array_binary_values, NR_CHECK_VALUES, sizeof(bin_dec_keypair), compar);
    
    res = (bin_dec_keypair*) bsearch (input_keypair, array_binary_values, NR_CHECK_VALUES, sizeof(array_binary_values[0]), compar);

    if (res != NULL){
        if(res->decimal == input_keypair->decimal) {
            printf ("\tPassed\n\n");
        }
        else{
            puts("\tThe binary string was found but it did not matched entered decimal\n");
        }
        return;
    }
    puts("\tNot found or incorrect string\n");
}

