@interface YDPrettyConsole : NSOperation
@end

@implementation YDPrettyConsole
-(instancetype)init{
    self = [super init];
    if (self) {
        return self;
    }
    return NULL;
}

-(void)backgroundWork:(char)c{

    for (int i = 0; i < 4; i++) {
            usleep(1000000);
            putchar(c);
    }
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSMutableArray *arrayOfOps = [NSMutableArray new];

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperationWithBlock:^{
            NSLog(@"Thread from Init:%@", [NSThread currentThread]);
            YDPrettyConsole *console = [YDPrettyConsole new];
            
            NSLog(@"Operation isReady:%hhd", console.isReady);
            NSLog(@"Operation isExecuting:%hhd", console.isExecuting);
            NSLog(@"Operation isFinished:%hhd", console.isFinished);
            [console backgroundWork:'!'];
            console.queuePriority = NSOperationQueuePriorityLow;
            console.qualityOfService = NSOperationQualityOfServiceBackground;
            NSLog(@"Operation isReady:%hhd", console.isReady);
            NSLog(@"Operation isExecuting:%hhd", console.isExecuting);
            NSLog(@"Operation isFinished:%hhd", console.isFinished);
        }];

        NSLog(@"Thread from Main:%@: main: %hhd", [NSThread currentThread], [NSThread isMainThread]);
        [queue waitUntilAllOperationsAreFinished];

    }
    return 0;
}

