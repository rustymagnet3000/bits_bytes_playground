#ifdef __OBJC__
    #import <Foundation/Foundation.h>
#endif

/*
    https://stackoverflow.com/questions/695980/how-do-i-declare-class-level-properties-in-objective-c
    WWDC 2016/XCode 8 (what's new in LLVM session @5:05) added to ObjC after being introduced in Swift.
 */

@interface Foobar : NSObject
@property (class) int result;
@end

@implementation Foobar

static int _result;

+ (int)result
{
    return _result;
}

+ (void)setResult:(int)result {
    _result = result;
}

@end


int main(void) {
    @autoreleasepool {
        NSLog(@"Result: %d",[Foobar result]);      // At app start-up
        [Foobar setResult:99];                     // setter called
        NSLog(@"Result: %d",[Foobar result]);      // getter called
    }
}

