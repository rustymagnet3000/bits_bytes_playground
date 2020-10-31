#include <stdio.h>

// Baboon
// 0x42, 0x61, 0x62, 0x6f, 0x6f, 0x6e
// 6E6F6F626142
// 4261626F6F6E

const int animalByteArray[7] = { 66, 97, 98, 111, 111, 110 };

void foo_func ( const void *ptr ) {
    printf ( "\n[*]Pointer: %p.\n", ptr );        /* breakpoint here */
}

int main ( void ) {

    const int *ptr = animalByteArray;

    puts ("[*]Can you change the animal?\n");
    for ( ; *ptr != '\0'; ++ptr )
       printf ( "%c", *ptr );

    foo_func ( ptr );
    return 0;
}


/* Why does lldb struggle to find it ?  It memory it is written: "B...a...""

Baboon(lldb) mem find -s "B" -c 3 -- 0x00000100000000 0x00000100004000
data found at location: 0x100003f60
0x100003f60: 42 00 00 00 61 00 00 00 62 00 00 00 6f 00 00 00  B...a...b...o...
0x100003f70: 6f 00 00 00 6e 00 00 00 00 00 00 00 0a 5b 2a 5d  o...n........[*]
*/

//strings objc_play
//[*]Pointer: %p.
//[*]Can you change the animal?


/* but it won't hide it from a more powerful tool

 ▶ rabin2 -qz objc_play
 0x100003f60 28 6 Baboon
 0x100003f7c 18 17 \n[*]Pointer: %p.\n
 0x100003f8e 31 30 [*]Can you change the animal?\n
  */
