#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// https://gist.github.com/mikeash/7603035
// https://www.bignerdranch.com/blog/inside-the-bracket-part-7-runtime-machinations/
// http://www.alejandrosegovia.net/2012/08/06/dynamic-method-injection-in-objective-c/
// http://labs.distriqt.com/post/846
// https://github.com/hsnamr/Create-ObjC-Class-At-Runtime

/* To add a method and ivar at run-time sounds simple but Automatic Reference Counting (ARC) stopped me for a long time. The below code won't compile with ARC on.

https://stackoverflow.com/questions/20582642/why-arc-forbids-calls-to-undeclared-methods/20582863#20582863
*/

@interface Glorn : NSObject
@end

@implementation Glorn
@end

static NSString *Larvoid (id self, SEL _cmd) {
    return @"Zogg";
}

int main() {
    @autoreleasepool {
        Class glornClass = [Glorn class];
        Glorn *glorn = [[Glorn alloc] init];
        NSString *name = @"";
        
        BOOL success = class_addMethod (glornClass, @selector(larvoid),
                                        (IMP)Larvoid, "@:v");
        
        class_addIvar(glornClass, "_name", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));

        
        if ([glorn respondsToSelector:@selector(larvoid)]) {
            name = [glorn larvoid];
            NSLog (@"Hello my name is %@", name);
        }
        
        char *encoding;
        IMP blockImp =
        imp_implementationWithBlock ((__bridge void *)
                                     ^(id self, NSUInteger count) {
                                         for (NSUInteger i = 0; i < count; i++) {
                                             NSLog (@"Hello #%ld, %@", i, name);
                                         }
                                     });
        
        asprintf(&encoding, "v@:%s", @encode(NSUInteger));
        success = class_addMethod (glornClass, @selector(greetingWithCount:),
                                   blockImp, encoding);
        free (encoding);
        
        if ([glorn respondsToSelector:@selector(greetingWithCount:)]) {
            [glorn greetingWithCount: 5];
        }
        
    }
    return 0;
}
