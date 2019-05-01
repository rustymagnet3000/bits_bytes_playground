#import <Foundation/Foundation.h>
#include <stdio.h>
#include <objc/objc.h>
#include <objc/runtime.h>

@interface YDHelloClass : NSObject
-(void)sayHello;
-(void) newHello;
+(void)sayStaticHello;
+(void) newStaticHello;
@end

@implementation YDHelloClass

-(void) sayHello
    {
        puts("[+]Hello. Foo.");
    }
-(void) newHello
    {
        puts("[+]🍭 Swizzled. Bar.");
    }
+(void) sayStaticHello
    {
        puts("[+]A static hello. Foo.");
    }
+(void) newStaticHello
    {
        puts("[+]🍭 Swizzled. Bar. Static.");
    }
@end

void YDSwizzleInstanceMethod(Class c, SEL original, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, original);
    Method newMethod = class_getInstanceMethod(c, new);

    if (class_addMethod(c, original, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

void YDSwizzleClassMethod(Class c, SEL orig, SEL new) {

    Method origMethod = class_getClassMethod(c, orig);
    Method newMethod = class_getClassMethod(c, new);

    c = object_getClass((id)c);

    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
    class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
    method_exchangeImplementations(origMethod, newMethod);
}

int main() {
    @autoreleasepool {
        YDHelloClass *hello = [[YDHelloClass alloc] init];
        [hello sayHello];
        [YDHelloClass sayStaticHello];

        YDSwizzleInstanceMethod(YDHelloClass.self, @selector(sayHello), @selector(newHello));
        YDSwizzleClassMethod(YDHelloClass.self, @selector(sayStaticHello), @selector(newStaticHello));

        [hello sayHello];
        [YDHelloClass sayStaticHello];
    }
    return 0;
}

/*
[+]Hello. Foo.
[+]A static hello. Foo.
[+]🍭 Swizzled. Bar.
[+]🍭 Swizzled. Bar. Static.
*/
