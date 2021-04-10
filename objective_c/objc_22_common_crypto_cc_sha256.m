#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonDigest.h>

/*  https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Standards-and-Guidelines/documents/examples/SHA256.pdf  */

int main(void) {
    @autoreleasepool {
        unsigned char bytes[] = { 0x61, 0x62, 0x63 };
        NSData *binaryData = [[NSData alloc] initWithBytes:bytes length:sizeof(bytes)];
        NSString *prettyStr = [[NSString alloc] initWithData:binaryData encoding:NSASCIIStringEncoding];
        NSLog(@"[*]Input:\t%@", prettyStr);

        unsigned char *messageDigest = malloc(CC_SHA256_DIGEST_LENGTH);

        /* returns NIL if an error and won't trigger if statement   */
        if (([binaryData bytes], (unsigned int) binaryData.length, messageDigest)){
            NSMutCC_SHA256ableString *hex = [NSMutableString string];
            while ( *messageDigest ) [hex appendFormat:@"%02X" , *messageDigest++ & 0x00FF]; /* doesn't deal with NULL bytes */
            NSLog(@"[*]Encoded:\t%@", hex);
        }
        
        messageDigest = NULL;
        free(messageDigest);
    }
    return 0;
}

/*
     extern unsigned char *
        CC_SHA256(const void *data, CC_LONG len, unsigned char *md);
     
     (lldb) b CC_SHA256          // at the start of the code, set an auto-continue on the breakpoint
     
     Breakpoint 2: where = libcommonCrypto.dylib`CC_SHA256, address = 0x00007fff6c4c0849

     (lldb) po (char *) $arg1
     "DEADFACE"
     
     (lldb) po $arg2
     9

     (lldb) po $arg3
     <nil>
*/
