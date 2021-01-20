#import <Foundation/Foundation.h>
#include <objc/runtime.h>

@interface SwizzleHelper: NSObject {
    SEL _originalSelector, _replacementSelector;
    Class _targetClass, _targetSuperClass;
    Method _originalMethod, _swizzledMethod;
}
 
- (id) initWithTargets: (const char *)target Original:(SEL)orig Swizzle:(SEL)swiz;
- (NSString *) getDescription;

@end


@implementation SwizzleHelper: NSObject

- (NSString *) getDescription {
    NSString *verbose = [NSString stringWithFormat:@"🍭Swizzle:\n\tTargeted class:\t%@\n\tSuperclass:\t%@", NSStringFromClass(_targetClass), NSStringFromClass(_targetSuperClass)];
    return verbose;
}

- (void) swapMethods {
    
    BOOL didAddMethod = class_addMethod(_targetClass,
                                        _originalSelector,
                                        method_getImplementation(_swizzledMethod),
                                        method_getTypeEncoding(_swizzledMethod));
    
    if (didAddMethod) {
        NSLog(@"🍭 didAddMethod: %@ && Class: %@", NSStringFromSelector(_originalSelector), NSStringFromClass(_targetClass));
        
        class_replaceMethod(_targetClass,
                            _replacementSelector,
                            method_getImplementation(_originalMethod),
                            method_getTypeEncoding(_originalMethod));
    } else {
        NSLog(@"🍭 Method swap: %@", NSStringFromSelector(_originalSelector));
        method_exchangeImplementations(_originalMethod, _swizzledMethod);
    }
}

- (id) initWithTargets: (const char *)target
              Original:(SEL)orig
               Swizzle:(SEL)swiz {
    NSLog(@"🍭Swizzle setup started...");
    self = [super init];
    if (self) {
        _targetClass = objc_getClass(target);
        
        if (_targetClass == NULL) {
            NSLog(@"\t🍭Stopped swizzle. Could not find %s class", target);
            return NULL;
        }
        _targetSuperClass = class_getSuperclass(_targetClass);
        _originalSelector = orig;
        _replacementSelector = swiz;
        _originalMethod = class_getInstanceMethod(_targetClass, _originalSelector);
        _swizzledMethod = class_getInstanceMethod(_targetClass, _replacementSelector);
        
        if (_originalMethod == NULL || _swizzledMethod == NULL) {
                NSLog(@"🍭\tStopped swizzle. originalMethod:  %p swizzledMethod: %p \n", _originalMethod, _swizzledMethod);
                return NULL;
        }
        
        [self swapMethods];
    }
    return self;
}
@end

@implementation NSURL (YDSwizzleNSURL)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL orig = @selector(initWithString:);
        SEL swiz = @selector(YDHappyURLInspector:);
        const char* rawTarget = "NSURL";
        SwizzleHelper *swizzle = [[SwizzleHelper alloc] initWithTargets:rawTarget Original:orig Swizzle:swiz];

        if (swizzle != NULL){
            NSLog(@"%@", [swizzle getDescription]);
        }
    });
}

- (instancetype)YDHappyURLInspector:(NSString *)string{
    NSLog(@"🍭NSURL request: %@", string);
    return [self YDHappyURLInspector: string];
}

@end

int main()
{
    @autoreleasepool
    {
        __unused NSURL *a = [[NSURL alloc] initWithString:@"Foo"];
        __unused NSURL *b = [[NSURL alloc] initWithString:@"Bar"];
    }
    return 0;
}

