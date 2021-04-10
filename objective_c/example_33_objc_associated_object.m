#ifdef __OBJC__
    #import <Foundation/Foundation.h>
    #include <objc/runtime.h>
#endif


// https://rosettacode.org/wiki/Add_a_variable_to_a_class_instance_at_runtime#Objective-C

static void *fooKey = &fooKey; // define a unique key

@interface Foobar : NSObject

@end

@implementation Foobar


@end


int main() {
    @autoreleasepool {

               id e = [[Foobar alloc] init];
        
               // set
               objc_setAssociatedObject(e, fooKey, @1, OBJC_ASSOCIATION_RETAIN);
        
               // get
               NSNumber *associatedObject = objc_getAssociatedObject(e, fooKey);
               NSLog(@"associatedObject: %@", associatedObject);

    }
    return 0;
}

