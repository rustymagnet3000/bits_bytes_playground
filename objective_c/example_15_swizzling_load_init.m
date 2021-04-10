#import <Foundation/Foundation.h>
#import <objc/message.h>

// https://darkdust.net/writings/objective-c/method-swizzling
// https://www.ios-blog.com/tutorials/objective-c/storing-data-with-nsuserdefaults/
// https://www.bignerdranch.com/blog/by-your-command/
// https://stackoverflow.com/questions/7982740/where-is-a-mac-applications-nsuserdefaults-data-stored

@interface NSUserDefaults(Timing)
@end


@implementation NSUserDefaults(Timing)

+ (void)load
{
    printf("[+] placing Hook via load method\n");
    Method original, swizzled;
    original = class_getInstanceMethod(self, @selector(synchronize));
    swizzled = class_getInstanceMethod(self, @selector(swizzled_synchronize));
    method_exchangeImplementations(original, swizzled);
}

- (BOOL)swizzled_synchronize
{
    NSDate *started;
    BOOL returnValue;
    
    started = [NSDate date];
    returnValue = [self swizzled_synchronize];
    NSLog(@"[+] Writing user defaults took %f seconds.", [[NSDate date] timeIntervalSinceDate:started]);
    
    return returnValue;
}

@end



int main () {
    
    @autoreleasepool {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:9001 forKey:@"HighScore"];
        [defaults synchronize];
        NSInteger theHighScore = [defaults integerForKey:@"HighScore"];
        NSLog(@"[+] High score: %ld", theHighScore);
    }
    return 1;
}

