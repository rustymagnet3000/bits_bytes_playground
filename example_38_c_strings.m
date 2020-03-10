#include <stdio.h>
#include <stdlib.h>

int main(void) {

    /******************    C String, Stack           *****************/
    char c_str_1[11] = {'C',' ','s', 't', 'r', 'i', 'n', 'g', ' ', '1','\0'};
    puts(c_str_1);
    /******************    C String, Stack           *****************/
    char c_str_2[] = "C string 2";
    puts(c_str_2);
    /******************    C String, Heap malloc     *****************/
    char *c_str_3 = malloc(6);
    c_str_3[0] = 'C';
    c_str_3[1] = ' ';
    c_str_3[2] = 'S';
    c_str_3[3] = 't';
    c_str_3[4] = 'r';
    c_str_3[5] = '\0';
    puts(c_str_3);
    /******************    C String, Heap realloc    *****************/
    c_str_3 = realloc(c_str_3, 11);
    *(c_str_3 + 5) = 'i';
    *(c_str_3 + 6) = 'n';
    *(c_str_3 + 7) = 'g';
    *(c_str_3 + 8) = ' ';
    *(c_str_3 + 9) = '3';
    *(c_str_3 + 10) = '\0';
    puts(c_str_3);
    
    c_str_3 = NULL;
    free(c_str_3);
    
    return 0;
}
