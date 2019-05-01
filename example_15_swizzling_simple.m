#import <Foundation/Foundation.h>
#include <objc/message.h>

@interface YDGoT : NSObject
{
    NSString *_shareHolder;
}

- (id)initWithName:(NSString *)name;
- (BOOL)nameCheck;

@property NSString *shareHolder;
@end

@implementation YDGoT

- (id)initWithName:(NSString *)name
{
    _shareHolder = name;
    return self;
}

- (BOOL)nameCheck
{
    if ([_shareHolder  isEqual: @"Jon Snow"]){
        return TRUE;
    } else {
        return FALSE;
    }
}

@synthesize shareHolder = _shareHolder;
@end

@interface YDGoT (Winterfell)
- (BOOL)fakeNameCheck;
@end

@implementation YDGoT (Winterfell)

- (BOOL)fakeNameCheck
{
    BOOL result = [self fakeNameCheck];
    NSLog(@"[+] 🍭 swizzled. Orignal retval: %@", result ? @"YES" : @"NO");
    return TRUE;
}
@end


int main() {
    @autoreleasepool {

        YDGoT *gotPerson = [[YDGoT alloc] initWithName:@"Jon Snow"];

        NSLog(@"[+]Is %@ Warden of the North? %@", [gotPerson shareHolder], [gotPerson nameCheck] ? @"YES" : @"NO");

        Class myClass = [gotPerson class];
        SEL nameSel = @selector(nameCheck);
        SEL fakeNameSel = @selector(fakeNameCheck);

        Method original = class_getInstanceMethod(myClass, nameSel);
        Method replacement = class_getInstanceMethod(myClass, fakeNameSel);

        method_exchangeImplementations(original, replacement);

        objc_msgSend(gotPerson, @selector(initWithName:),@"Tyrion Lannister");
        NSLog(@"[+]Is %@ Warden of the North? %@", [gotPerson shareHolder], [gotPerson nameCheck] ? @"YES" : @"NO");
    }
    return 0;
}

/*
[+]Is Jon Snow Warden of the North? YES
[+] 🍭 swizzled. Orignal retval: NO
[+]Is Tyrion Lannister Warden of the North? YES
Program ended with exit code: 0
*/
