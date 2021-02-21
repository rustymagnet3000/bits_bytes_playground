#include "gmp.h"
#define BYTEARRAY_LEN 8

/* When decrypting, check whether it is a String, Hex String or long Decimal */

// const char bytes[BYTEARRAY_LEN] = { 0x41, 0x42, 0x43, 0x44, 0x31, 0x32, 0x33, 0x34 }; // ABCD1234
// const char bytes[BYTEARRAY_LEN] = { 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x00 }; // "Hello" with NULL terminator
// const char bytes[BYTEARRAY_LEN] = { 0x31, 0x31, 0x31, 0x32, 0x32, 0x32 }; // 1112222
const char bytes[BYTEARRAY_LEN] = { 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x21, 0x21 }; // "Hello!!"

@implementation FooBar: NSObject

+ (void) guessFormatOfDecryptedType: (NSString *)input{
    NSCharacterSet *hexChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEF"] invertedSet];
    NSCharacterSet *decimalChars = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSCharacterSet *alphanumericChars = [[NSCharacterSet alphanumericCharacterSet] invertedSet];

    puts("\n[+]NSString says:");
    if ([input rangeOfCharacterFromSet:decimalChars].location == NSNotFound){
        NSLog(@"\t\tGuessed decimal: %d", (int) input);
    }
    else if ([input rangeOfCharacterFromSet:hexChars].location == NSNotFound){
        NSLog(@"\t\tGuessed hex: %@", input);
    }
    else if ([input rangeOfCharacterFromSet:alphanumericChars].location == NSNotFound){
        NSLog(@"\t\tGuessed alphanumeric: %@", input);
    }
    else{
        NSLog(@"\t\tCannot guess.  Just trying default NSLog print: %@", input);
    }
}
@end

int main(void) {
    @autoreleasepool {

        mpz_t a; mpz_init( a );
        
        mpz_import ( a, BYTEARRAY_LEN, 1, sizeof(bytes[0]), 0, 0, bytes );
        
        size_t aLen;
        aLen = mpz_sizeinbase(a, 16);
        
        gmp_printf("[+]GMP says:\n\t\tBytes:%Zx (hex bytes)\n\t\tBytes:%Zd (%zu bits)", a, a, aLen );
        char *regurg = calloc(BYTEARRAY_LEN, sizeof(char));
        
        size_t *countp = NULL;
        mpz_export ( regurg, countp, 1, sizeof(char), 0, 0, a );
        
        if(countp)
            printf("[+] countp:(%p)\n", countp);
    
        NSString *regurgiatedStr = [[NSString alloc] initWithUTF8String:regurg];
        
        [FooBar guessFormatOfDecryptedType:regurgiatedStr];

        regurg = NULL;
        countp = NULL;
        free(regurg);
        free(countp);
        mpz_clear ( a );
    }
    return 0;
}

