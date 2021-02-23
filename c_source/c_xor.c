#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define OBFS_STRING "ccvczllB"

void yd_xor(const char* str){
    
    size_t len = strlen(str);
    char *xorStr = calloc(len, sizeof(char));
    
    printf("[*]Starting XOR on: %s\n[*]strlen(%zu)\n", str, len);
    for (int i = 0; i <= len; i++) {
        xorStr[i] = 0x42 ^ str[i];
        printf("%c\tXOR\t%c\n", str[i], xorStr[i]);
    }
    printf("[*]%s\n", xorStr);
    
    if (strcmp(OBFS_STRING, xorStr) == 0){
        puts("[*]Winner!\n");
    }
    xorStr = NULL;
    free(xorStr);
}

int main(void) {
    const char *testStr = "!!4!8..";
    yd_xor(testStr);
    return 0;
}

