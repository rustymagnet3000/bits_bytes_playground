#import <Foundation/Foundation.h>

@interface HelloLogger : NSObject
-(void) sayHello:(NSTimer *)t;
@end

@implementation HelloLogger

-(void) sayHello:(NSTimer *)t
{
    NSLog(@"hello world");
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        HelloLogger *logger = [[HelloLogger alloc] init];
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:logger selector:@selector(sayHello:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
