#define MAX_ARRAYS 5
#define MAX_STR_LEN 10

/* mind blowing pointer stuff https://www.eskimo.com/~scs/cclass/notes/sx10b.html   */

/*
   The Array of Byte Arrays is constant.
   It was declared as immutable (const).
   Don't expect to overwrite entries [ safely ] .
   It is wasteful, in terms of space.
   5 (MAX_ARRAYS) * 10 (MAX_STR_LEN) = 50 bytes.
   Only about 29 bytes + 5 NULL terminator (0x00) are actually used.
   The unused by are set to NULL.
*/

const char byteArrays[MAX_ARRAYS][MAX_STR_LEN] = {
        { 0x41, 0x42, 0x43, 0x31, 0x32, 0x33 },// ABC123
        { 0x48, 0x65, 0x6C, 0x6C, 0x6F }, // "Hello"
        { 0x68, 0x45, 0x4C, 0x4C, 0x4F }, // "hELLO"
        { 0x31, 0x31, 0x31, 0x32, 0x32, 0x32 }, // 1112222
        { 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x21, 0x21 } // "Hello!!"
};


int main(void) {

    const size_t elementsInByteArray = sizeof( byteArrays ) / sizeof( *byteArrays );
    printf("[+]Elements in array: %lu\n", elementsInByteArray);
    printf("[+]sizeof byte arrays: %lu\n", sizeof( byteArrays ));
    
    /*************************************************************************************/
    /* The cast to (char *) below mimics the char[] decaying into char*                  */
    /*************************************************************************************/
    char *startAddress = (char *)byteArrays;
    char *endAddress = (char *)byteArrays + sizeof( byteArrays );
    size_t sizeElements = sizeof(byteArrays[0]);
    
    printf("[+]Start address of byte arrays: %p\n", startAddress );
    printf("[+]End address of byte arrays: %p\n", endAddress);
    printf("[+]Each element is: %lu\n", sizeElements);
    
    char *p = startAddress;
    printf("[+]p = %p\n", p);
    printf("[+]p + 10 = %s (%p)\n", p + 10, p + 10);
    printf("[+]p points toward \t\t%p\n", p);
    
    /*************************************************************************************/
    /* We can increment the ptr as memory was contiguous                                 */
    /*************************************************************************************/

    while (startAddress < endAddress) {
        printf("%p\t\t\t\t= %s\n", startAddress, startAddress);
        startAddress = startAddress + sizeElements;
    }

    return 0;
}


[+]Elements in array: 5
[+]sizeof byte arrays: 50
[+]Start address of byte arrays: 0x100000ea0
[+]End address of byte arrays: 0x100000ed2
[+]Each element is: 10
[+]p = 0x100000ea0
[+]p + 10 = Hello (0x100000eaa)
[+]p points toward 		0x100000ea0
0x100000ea0				= ABC123
0x100000eaa				= Hello
0x100000eb4				= hELLO
0x100000ebe				= 111222
0x100000ec8				= Hello!!
Program ended with exit code: 0
