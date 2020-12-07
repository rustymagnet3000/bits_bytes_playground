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

static void __attribute__((constructor)) initialize(void){
    puts("[+]Hook being placed..");

    YDGoT *gotPerson = [[YDGoT alloc] initWithName:@"Tyrion"];
    Class myClass = [gotPerson class];
    SEL nameSel = @selector(nameCheck);
    SEL fakeNameSel = @selector(fakeNameCheck);

    Method original = class_getInstanceMethod(myClass, nameSel);
    Method replacement = class_getInstanceMethod(myClass, fakeNameSel);

    method_exchangeImplementations(original, replacement);

}

int main() {
    @autoreleasepool {

        YDGoT *gotPerson = [[YDGoT alloc] initWithName:@"Night King"];

        NSLog(@"[+] %@ \"Warden of the North\"? %@", [gotPerson shareHolder], [gotPerson nameCheck] ? @"YES" : @"NO");

    }
    return 0;
}

/*
[+]Hook being placed..
[+] 🍭 swizzled. Orignal retval: NO
[+] Night King "Warden of the North"? YES
*/
