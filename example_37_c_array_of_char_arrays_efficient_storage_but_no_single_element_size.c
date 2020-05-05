#define MAX_ARRAYS 5

/*
    The Array of Byte Arrays is constant.
    It was declared as immutable (const).
    It is efficient in terms of space.
    But it breaks the incrementing pointer:  startAddress = startAddress + sizeSingleElement;
    I used NULL terminators at the end of each string literal.
*/

const char *byteArrays[MAX_ARRAYS] = {
    (char []) { 0x41, 0x42, 0x43, 0x31, 0x32, 0x33, 0x00  },// ABC123
    (char []) { 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x00 }, // Hello\x0
    (char []) { 0x31, 0x31, 0x31, 0x32, 0x32, 0x32, 0x00 }, // 1112222
    (char []) { 0x44, 0x45, 0x41, 0x44, 0x46, 0x41, 0x43, 0x43, 0x45, 0x00 }, // "DEADFACE"
    (char []) { 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x21, 0x21, 0x00 } // "Hello!!"
};

int main(void) {
        
    const size_t elementsInByteArray = sizeof( byteArrays ) / sizeof( *byteArrays );
    printf("[+] Elements in array: %lu\n", elementsInByteArray);

    /*************************************************************************************/
    /* The cast to (char *) below mimics the char[] decaying into char*                  */
    /*************************************************************************************/
    char *startAddress = (char *) byteArrays[0];
    char *endAddress = (char *) byteArrays[ MAX_ARRAYS ];
    
    printf("[+] Start address of byte arrays: %p\n", startAddress );
    printf("[+] End address of byte arrays: %p\n", endAddress);
    
    /*************************************************************************************/
    /* CANNOT increment the ptr as memory is not a consistent length                     */
    /* byteArrays[i] gives you a pointer. But it does NOT give you the length in memory  */
    /* I used the terminating NULL byte to ensure it deliminated correctly               */
    /*************************************************************************************/

    size_t totalBytes = 0;
    for (int i = 0; i < MAX_ARRAYS; ++i){
        printf("[+]\t%s (strlen %lu) \t\t(address %p)\t\t%ld offset\n", byteArrays[i], strlen(byteArrays[i]), byteArrays[i],  byteArrays[i] - startAddress );
        totalBytes = totalBytes + strlen(byteArrays[i]);
    }
                                         
    printf("[+] Bytes used: %lu\n", totalBytes);
    return 0;
}


[+] Elements in array: 5
[+] Start address of byte arrays: 0x100001020
[+] End address of byte arrays: 0x0
[+]	ABC123 (strlen 6) 		(address 0x100001020)		0 offset
[+]	Hello (strlen 5) 		(address 0x100001027)		7 offset
[+]	111222 (strlen 6) 		(address 0x10000102d)		13 offset
[+]	DEADFACCE (strlen 9) 		(address 0x100001034)		20 offset
[+]	Hello!! (strlen 7) 		(address 0x10000103e)		30 offset
[+] Bytes used: 33
