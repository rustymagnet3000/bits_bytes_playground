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

    Class gotClass = [YDGoT class];

    SEL originalSel = @selector(nameCheck);
    SEL replacementSel = @selector(fakeNameCheck);

    Method originalMethod = class_getInstanceMethod(gotClass, originalSel);
    Method replacementMethod = class_getInstanceMethod(gotClass, replacementSel);

    BOOL didAddMethod =
        class_addMethod(gotClass,
                    originalSel,
                    method_getImplementation(replacementMethod),
                    method_getTypeEncoding(replacementMethod));

    NSLog(@"[+] didAddMethod returned: %@", didAddMethod ? @"YES" : @"NO");
    if (didAddMethod) {

        class_replaceMethod(gotClass,
                            replacementSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, replacementMethod);
    }
}

int main() {
    @autoreleasepool {

        YDGoT *gotPerson = [[YDGoT alloc] initWithName:@"Night King"];
        NSLog(@"[+] %@ \"Warden of the North\"? %@", [gotPerson shareHolder], [gotPerson nameCheck] ? @"YES" : @"NO");
    }

    return 0;
}


/*

[+] didAddMethod returned: NO
[+] 🍭 swizzled. Orignal retval: NO
[+] Night King "Warden of the North"? YES

*/
