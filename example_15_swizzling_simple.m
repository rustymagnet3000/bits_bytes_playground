#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface YDHelloClass : NSObject

-(NSInteger) getRandomNumber;

@end

@implementation YDHelloClass

-(NSInteger) getRandomNumber
{
    return arc4random_uniform(10000);
}

@end

@interface YDGoodbyeClass: NSObject
- (NSInteger)fakeRandomNumber;
@end

@implementation YDGoodbyeClass

- (NSInteger)fakeRandomNumber
{
    YDGoodbyeClass *goodbye = [[YDGoodbyeClass alloc] init];
    NSInteger retval = 42;
    if ([goodbye respondsToSelector:@selector(fakeRandomNumber)]) {
        NSInteger result = [goodbye fakeRandomNumber];
        NSLog(@"\n[+] 🍭 swizzled.Original retval: %ld \n[+] 🍭 New retval: %ld", result, retval);
    }
    else {
        NSLog(@"[+] 🍭 swizzled.");
    }

    return retval;
}

+ (void)load
{
    Class orignalClass = objc_getClass("YDHelloClass");

    if (orignalClass != nil) {
        NSLog(@"\n[+] 🎣 Found YDHelloClass\n[+] 🎣 Placing hook on getRandomNumber\n");
        Method original, swizzled;
        original = class_getInstanceMethod(orignalClass, @selector(getRandomNumber));
        swizzled = class_getInstanceMethod(self, @selector(fakeRandomNumber));
        if(original != nil && swizzled != nil)
            method_exchangeImplementations(original, swizzled);
    }
}

@end

int main() {
    @autoreleasepool {
        YDHelloClass *hello = [[YDHelloClass alloc] init];
        [hello getRandomNumber];
    }
    return 0;
}


/*
 [+] 🎣 Found YDHelloClass
 [+] 🎣 Placing hook on getRandomNumber
 [+] 🍭 swizzled.Original retval: 7966
 [+] 🍭 New retval: 42
 */
