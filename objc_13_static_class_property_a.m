#import <Foundation/Foundation.h>

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
