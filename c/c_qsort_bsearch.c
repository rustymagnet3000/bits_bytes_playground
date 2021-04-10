http://icarus.cs.weber.edu/~dab/cs1410/textbook/8.Strings/qsort.html
https://stackoverflow.com/questions/43872655/bsearch-finding-a-string-in-an-array-of-structs
http://www.cplusplus.com/reference/cstdlib/bsearch/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define NR_CHECK_VALUES (sizeof(array_binary_values)/sizeof(array_binary_values[0]))

typedef struct {
    int decimal;
    char *bin_string;
} bin_dec_keypair;

static bin_dec_keypair array_binary_values[] = {
            { 10, "1010" },
            { 15, "1111" },
            { 255, "11111111" },
            { 127, "1111111" },
            { 100000, "11110100001001000000" },
            { 16, "10000" }
};

static int compmi(const void *m1, const void *m2)
{
    bin_dec_keypair *mi1 = (bin_dec_keypair *) m1;
    bin_dec_keypair *mi2 = (bin_dec_keypair *) m2;
    return strcmp(mi1->bin_string, mi2->bin_string);
}

int main(int argc, char **argv)
{
    bin_dec_keypair *res;
    bin_dec_keypair struct_to_verify = {.decimal = 256, .bin_string = "11111111"};

    qsort(array_binary_values, NR_CHECK_VALUES, sizeof(bin_dec_keypair), compmi);
    
    res = (bin_dec_keypair*) bsearch (&struct_to_verify, array_binary_values, NR_CHECK_VALUES, sizeof(array_binary_values[0]), compmi);

    if (res != NULL)
        printf ("%d is in the array.\n",res->decimal);
    else
        printf ("%d not in the array.\n",struct_to_verify.decimal);
    return 0;
}

