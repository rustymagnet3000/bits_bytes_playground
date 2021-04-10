#import <Foundation/Foundation.h>

// based on Apple's example of Pass By Reference NSError: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/ErrorHandling/ErrorHandling.html
@implementation FooBar: NSObject

+(BOOL) weirdStaticMethod: (NSError **) error {

    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"A pretty localized error message.", nil) };
    
    if (error) {
        *error = [NSError errorWithDomain:@"com.Bits.Bytes"
                                     code:-9
                                 userInfo:userInfo];
    }
    return NO;
}

@end

int main(void) {
    @autoreleasepool {

        NSError *anyError;
        BOOL success = YES;
        success = [FooBar weirdStaticMethod:&anyError];

        if (!success) {
            NSLog(@"Failed with: %@", [anyError localizedDescription]);
            // present error to user
        }
        
    }
    return 0;
}


// Failed with: A pretty localized error message.

