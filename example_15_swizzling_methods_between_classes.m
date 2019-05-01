#import <Foundation/Foundation.h>
#include <stdio.h>
#include <objc/objc.h>
#include <objc/runtime.h>

@interface YDHelloClass : NSObject
    +(void)sayStaticHello;
@end

@implementation YDHelloClass

+(void) sayStaticHello
    {
        puts("[+]A static hello. Foo.");
    }
@end

@interface YDGoodbyeClass : NSObject
    +(void) sayGoodBye;
@end

@implementation YDGoodbyeClass

+(void) sayGoodBye
    {
        puts("[+]🍭 sayGoodBye");
    }
@end

void YDSwizzleClassMethod(Class origClass, Class fakeClass, SEL orig, SEL fake) {

    Method origMethod = class_getClassMethod(origClass, orig);
    Method newMethod = class_getClassMethod(fakeClass, fake);

    origClass = object_getClass((id)origClass);
    fakeClass = object_getClass((id)fakeClass);
    if(class_addMethod(origClass, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
    class_replaceMethod(origClass, fake, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
    method_exchangeImplementations(origMethod, newMethod);
}

int main() {
    @autoreleasepool {
        [YDHelloClass sayStaticHello];
        YDSwizzleClassMethod(YDHelloClass.self, YDGoodbyeClass.self, @selector(sayStaticHello), @selector(sayGoodBye));
        [YDHelloClass sayStaticHello];
    }
    return 0;
}

/*
[+]A static hello. Foo.
[+]🍭 sayGoodBye
*/
