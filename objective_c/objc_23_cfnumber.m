#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>

int main(void) {
    @autoreleasepool {

        int tempInt = 42;
        CFNumberRef cfNum1 = CFNumberCreate (NULL,
                                            kCFNumberSInt32Type,
                                            &tempInt);
        NSInteger tempNSInt = 2000;
        CFNumberRef cfNum2 = CFNumberCreate (NULL,
                                            kCFNumberNSIntegerType,
                                            &tempNSInt);

        CGFloat tempFloat = -242.5;
        CFNumberRef cfNum3 = CFNumberCreate (NULL,
                                            kCFNumberCGFloatType,
                                            &tempFloat);
        
        CFShow(cfNum1);
        NSLog(@"Number: %@", cfNum1);
        NSLog(@"Number: %@", cfNum2);
        NSLog(@"Number: %@", cfNum3);
        CFRelease(cfNum1);
        CFRelease(cfNum2);
        CFRelease(cfNum3);
    }
}
