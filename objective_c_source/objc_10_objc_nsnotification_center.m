#import <Foundation/Foundation.h>

@interface HelloLogger : NSObject
-(void) sayHello:(NSTimer *)t;
@end

@implementation HelloLogger

-(void) sayHello:(NSTimer *)t
{
    NSLog(@"timezone was changed");
}

@end

// go into System Preferences and change the Timezone to watch the NSLog message
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        HelloLogger *logger = [[HelloLogger alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:logger selector:@selector(sayHello:) name:NSSystemTimeZoneDidChangeNotification object:nil];
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
