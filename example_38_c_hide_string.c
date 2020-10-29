#include <stdio.h>

// Baboon
// 0x42, 0x61, 0x62, 0x6f, 0x6f, 0x6e
// 6E6F6F626142
// 4261626F6F6E

const int animalByteArray[7] = { 66, 97, 98, 111, 111, 110 };

void foo_func ( const void *ptr ) {
    printf ( "[*]Pointer: %p.\n", ptr );        /* breakpoint here */
}

int main ( void ) {

    const int *ptr = animalByteArray;
    
    puts ("[*]Can you change the animal?\n");
    for ( ; *ptr != '\0'; ++ptr )
       printf ( "%c", *ptr );
    
    foo_func ( ptr );
    return 0;
}
