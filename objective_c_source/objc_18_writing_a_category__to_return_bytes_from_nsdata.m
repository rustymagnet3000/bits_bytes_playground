#import <Foundation/Foundation.h>

@implementation NSData (HexRepresentation)

- (NSString *)hexString {
    const unsigned char *bytes = (const unsigned char *)self.bytes;
    NSMutableString *hex = [NSMutableString new];
    for (NSInteger i = 0; i < self.length; i++) {
        [hex appendFormat:@" %02x", bytes[i]];
    }
    return [hex copy];
}

@end

int main(void) {
    @autoreleasepool {

        unsigned char bytes[] = {0x01, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37 };
        NSData *binaryStr = [[NSData alloc] initWithBytes:bytes length:sizeof(bytes)];
        NSString *prettyStr = [[NSString alloc] initWithData:binaryStr encoding:NSASCIIStringEncoding];
        
        NSLog(@"\n[*] %@\n[*] %@", prettyStr, [binaryStr hexString]);
        
    }
    return 0;
}

/*
 [*] \^A1234567
 [*]  01 31 32 33 34 35 36 37
*/

