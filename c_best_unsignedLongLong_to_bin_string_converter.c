#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define CHAR_ARRY_MAX 64
#define INT_ARRY_MAX 16
#define NR_CHECK_VALUES (sizeof(array_binary_values)/sizeof(array_binary_values[0]))

typedef struct {
    unsigned long long decimal;
    char *bin_string;
} bin_dec_keypair;

void to_binary(unsigned long long ullDecimal, char *buf, int *i);
void verify_result(bin_dec_keypair *input_keypair);


static bin_dec_keypair array_binary_values[] = {
            { 10, "1010" },
            { 15, "1111" },
            { 255, "11111111" },
            { 127, "1111111" },
            { 1223, "10011000111" },                            // prime
            { 11483, "10110011011011" },                        // prime
            { 7919, "1111011101111" },                          // prime
            { 1000000, "11110100001001000000" },                // 1 billion
            { 99, "1100100" },                                  // incorrect, by design. Value is 100.
            { 16, "10000" },
            { 1000000000, "111011100110101100101000000000" },   // 1 billion
            { 3000000000, "10110010110100000101111000000000" },   // 3 billion
            { 12000000000, "1011001011010000010111100000000000" },    // 12 billion
            { 18446744073709551615uLL, "1111111111111111111111111111111111111111111111111111111111111111" }    // Biggest Unsigned Long Long
};

int main(void) {
    int index = 0;

    unsigned long long inputs[INT_ARRY_MAX] = {
            7919, 11483, 8, 9, 100, 10 , 15 , 16, 127, 255, 1223, 1000000, 1000000000, 3000000000, 12000000000, 18446744073709551615ull};
    
    size_t n = sizeof(inputs)/sizeof(inputs[INT_ARRY_MAX]);

    int i = 0;
    do {
        char *binaryStr = calloc(CHAR_ARRY_MAX, sizeof(char));
        char *revbinStr = calloc(CHAR_ARRY_MAX, sizeof(char));
        to_binary(inputs[i], binaryStr, &index);
        for (int i = 0; binaryStr[i] != '\0'; i++)
            revbinStr[i] = binaryStr[index - i];

        printf("[*] %llu\tBinary String:\t%s\n", inputs[i], revbinStr);
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
            printf ("\tPassed\n");
        }
        else{
            puts("\tBinary string found but it did not match the entered decimal");
        }
        return;
    }
    puts("\tNot found or incorrect string");
}


/* Outputs..
 
 [*] 7919    Binary String:    1111011101111
     Passed
 [*] 11483    Binary String:    10110011011011
     Passed
 [*] 8    Binary String:    1000
     Not found or incorrect string
 [*] 9    Binary String:    1001
     Not found or incorrect string
 [*] 100    Binary String:    1100100
     Binary string found but it did not match the entered decimal
 [*] 10    Binary String:    1010
     Passed
 [*] 15    Binary String:    1111
     Passed
 [*] 16    Binary String:    10000
     Passed
 [*] 127    Binary String:    1111111
     Passed
 [*] 255    Binary String:    11111111
     Passed
 [*] 1223    Binary String:    10011000111
     Passed
 [*] 1000000    Binary String:    11110100001001000000
     Passed
 [*] 1000000000    Binary String:    111011100110101100101000000000
     Passed
 [*] 3000000000    Binary String:    10110010110100000101111000000000
     Passed
 [*] 12000000000    Binary String:    1011001011010000010111100000000000
     Passed
 [*] 18446744073709551615    Binary String:    1111111111111111111111111111111111111111111111111111111111111111
     Passed
 Program ended with exit code: 0
*/

