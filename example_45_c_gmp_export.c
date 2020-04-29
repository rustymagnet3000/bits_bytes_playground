#include "gmp.h"
#define HEX_STR_LEN 8
#define TXT_STR_LEN 7
#define DEC_STR_LEN 6

int main(void) {
    @autoreleasepool {

        /* When decrypting, check whether it is a String, Hex String or long Decimal */
        
        const char bytesA[HEX_STR_LEN] = { 0x41, 0x42, 0x43, 0x44, 0x31, 0x32, 0x33, 0x34 }; // ABCD1234 Hex string
        const char bytesB[TXT_STR_LEN] = { 0x48, 0x6F, 0x65, 0x6C, 0x6C, 0x6F, 0x00 }; // "Hello" string
        const char bytesC[DEC_STR_LEN] = { 0x31, 0x31, 0x31, 0x32, 0x32, 0x32 }; // 1112222
        
        mpz_t a, b, c;
        mpz_inits( a, b, c, NULL );

        mpz_import ( a, HEX_STR_LEN, 1, sizeof(bytesA[0]), 0, 0, bytesA );
        mpz_import ( b, HEX_STR_LEN, 1, sizeof(bytesB[0]), 0, 0, bytesB );
        mpz_import ( c, HEX_STR_LEN, 1, sizeof(bytesC[0]), 0, 0, bytesC );
        
        size_t aLen;
        aLen = mpz_sizeinbase(a, 16);
        
        gmp_printf("[+] Bytes A:%Zx (%zu bits)\n", a, aLen);

        char *regurgA = calloc(HEX_STR_LEN, sizeof(char));
        char *regurgB = calloc(TXT_STR_LEN, sizeof(char));
        char *regurgC = calloc(DEC_STR_LEN, sizeof(char));
        
        size_t *countp = NULL;
        mpz_export ( regurgA, countp, 1, sizeof(char), 0, 0, a );
        mpz_export ( regurgB, NULL, 1, sizeof(char), 0, 0, b );
        mpz_export ( regurgC, NULL, -1, sizeof(char), 0, 0, c );
        
        if(countp)
            printf("[+] countp:(%p)\n", countp);
    
        NSString *regurgiatedStr = [[NSString alloc] initWithUTF8String:regurgA];
        NSData *binaryStr = [[NSData alloc] initWithBytes:regurgA length:HEX_STR_LEN];
        NSString *prettyStr = [[NSString alloc] initWithData:binaryStr encoding:NSASCIIStringEncoding];
        NSLog(@"[+] Back with NSString.\n\t\tBytes A:%@", regurgiatedStr);
        NSLog(@"\t\tBytes A integerValue:%ld\n", (long)[regurgiatedStr integerValue]);
        NSLog(@"\t\tBytes A from NSData %@\n", prettyStr);
        
        regurgA = NULL;
        regurgB = NULL;
        regurgC = NULL;
        countp = NULL;
        free(regurgA);
        free(regurgB);
        free(regurgC);
        free(countp);
        mpz_clears ( a, b, c, NULL );
    }
    return 0;
}
