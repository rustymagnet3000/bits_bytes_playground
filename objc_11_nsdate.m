@implementation FooBar : NSObject
+ (NSString *)prettyDate: (NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss:mm"];
    return [dateFormat stringFromDate:date];
}
@end


int main() {
    @autoreleasepool {
        NSDate *startTime = [NSDate date];
        NSDate *endTime = [[NSDate date] dateByAddingTimeInterval:60];
        NSLog(@"Start: %@", [FooBar prettyDate:startTime]);
        NSLog(@"End: %@", [FooBar prettyDate:endTime]);
        float timeDifference = [endTime timeIntervalSinceDate:startTime];
        NSLog(@"Time difference: %.1f", timeDifference);        
    }
    return 0;
}

