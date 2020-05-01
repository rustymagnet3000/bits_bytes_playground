#define MAX_ARRAYS 5
#define MAX_STR_LEN 10


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
    printf("Elements in array: %lu\n", elementsInByteArray);
    
    for (int i = 0; i < elementsInByteArray; ++i) {
        puts( byteArrays[i] );
        printf("\t\t(strlen %lu)\n\t\t(sizeof %lu)\n", strlen(byteArrays[i]), sizeof(byteArrays[i]));
    }

    return 0;
}



Elements in array: 5
ABC123
		(strlen 6)
		(sizeof 10)
Hello
		(strlen 5)
		(sizeof 10)
hELLO
		(strlen 5)
		(sizeof 10)
111222
		(strlen 6)
		(sizeof 10)
Hello!!
		(strlen 7)
		(sizeof 10)
