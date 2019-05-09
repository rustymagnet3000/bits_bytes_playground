#import <Foundation/Foundation.h>
#include <objc/message.h>

@interface YDHelloClass : NSObject
+(void)sayStaticHello;
@end

@implementation YDHelloClass

+(void) sayStaticHello
{
    puts("[+]\"hello\" from a Class function.");
}
@end

@interface YDGoodbyeClass : NSObject
+(void) sayGoodBye;
@end

@implementation YDGoodbyeClass

+(void) sayGoodBye{
    puts("[+]🍭\"Goodbye\" from a Class function.");
}

+(void) load {
    puts("[+]🍭 Swizzle started..");
    Class oriClass = objc_getClass("YDHelloClass");
    Class repClass = objc_getClass("YDGoodbyeClass");

    SEL oriSel = @selector(sayStaticHello);
    SEL repSel = @selector(sayGoodBye);

    id oriClassID = object_getClass((id)oriClass);
    id repClassID = object_getClass((id)repClass);

    Method replacement = class_getInstanceMethod(repClassID, repSel);
    Method original = class_getInstanceMethod(oriClassID, oriSel);

    if(class_addMethod(oriClassID, repSel, method_getImplementation(replacement), method_getTypeEncoding(replacement))){
        puts("[+]🍭 Attempting class_addMethod...");
        if (class_respondsToSelector(oriClassID, repSel)){
            puts("[+]🍭 class_addMethod success.");
            IMP blah = class_replaceMethod(oriClassID, oriSel, method_getImplementation(replacement), method_getTypeEncoding(original));
            if (blah != Nil){
                puts("[+]🍭 class_replaceMethod success.");
            }
        }
    }
}
@end

int main() {
    @autoreleasepool {
        [YDHelloClass sayStaticHello];
    }
    return 0;
}


/*
 
 [+]🍭 Swizzle started..
 [+]🍭 Attempting class_addMethod  ..
 [+]🍭 class_addMethod success.
 [+]🍭 class_replaceMethod success.
 [+]🍭"Goodbye" from a Class function.

 */
