#ifdef __OBJC__
    #import <Foundation/Foundation.h>
#endif

@interface Foobar : NSObject{
    NSNumber *_a;
    NSNumber *_b;
}
@property (readwrite) int result;
@end

@implementation Foobar
@synthesize result;
- (id)init {
    self = [super init];
    if (self){
        _a = [[NSNumber alloc] initWithInt:6];
        _b = [[NSNumber alloc] initWithInt:7];
        result = [_a intValue] * [_b intValue];
    }
    return self;
}
@end


int main(void) {
    @autoreleasepool {
        Foobar *foo = [Foobar new];
        NSLog(@"Result: %d",[foo result]);
        [foo setResult:55];                     // setter called
        NSLog(@"Result: %d",[foo result]);      // getter called
    }
}

/*
(lldb) lookup Foobar
****************************************************
3 hits in: tinySwizzle
****************************************************
-[Foobar init]

-[Foobar result]

-[Foobar setResult:]
 */

