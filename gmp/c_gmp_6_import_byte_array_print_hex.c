#include "gmp.h"

int main(void) {
    @autoreleasepool {

        unsigned char byteArray[] = {0x05, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37 };

        mpz_t z; mpz_init(z);

       // Import Byte Array into mpz_t struct
        mpz_import (z, sizeof(byteArray), 1, sizeof(byteArray[0]), 0, 0, byteArray);

        // Length in Bits
        size_t zLen;
        zLen = mpz_sizeinbase(z, 2);

        /* GMP's printf  */
        gmp_printf("[+]\tZ in Decimal: %Zd (%zu bits)\n", z, zLen);
        gmp_printf("[+]\tZ in Hex: %Zx \n", z);
        
        mpz_clear (z);
        
    }
    return 0;
}
