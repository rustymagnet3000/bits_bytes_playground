#define INT_ARRY_MAX 9

@implementation FooBar : NSObject

+ (void)prettyTimeFromSeconds: (NSTimeInterval)timeInSecs
{
    NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
    componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropLeading;
    NSString *formattedString = [componentFormatter stringFromTimeInterval:timeInSecs];
    NSLog(@"%@",formattedString);
}
@end


int main(void) {
    @autoreleasepool {
    
    NSDate *startTime = [NSDate date];
    NSDate *endTime;
        
    const unsigned long long timeInSecondsArray[INT_ARRY_MAX] = { 8, 9, 60, 7919, 11483, 3600 , 7201, 222222, 1111111111 };
    
        for (int i = 0; i < INT_ARRY_MAX; i++) {
            endTime = [[NSDate date] dateByAddingTimeInterval:timeInSecondsArray[i]];
            NSTimeInterval difference = [endTime timeIntervalSinceDate:startTime];
            [FooBar prettyTimeFromSeconds:difference];
        }
    }
    return 0;
}


8 seconds
9 seconds
1 minute, 0 seconds
2 hours, 11 minutes, 59 seconds
3 hours, 11 minutes, 23 seconds
1 hour, 0 minutes, 0 seconds
2 hours, 0 minutes, 1 second
2 days, 13 hours, 43 minutes, 42 seconds
35 years, 2 months, 2 weeks, 3 days, 1 hour, 58 minutes, 31 seconds
Program ended with exit code: 0
