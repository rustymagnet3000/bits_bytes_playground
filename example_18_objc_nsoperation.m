// https://nshipster.com/nsoperation/
// https://www.appcoda.com/understanding-key-value-observing-coding/

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

#import <Foundation/Foundation.h>
#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
#include <pthread.h>

@interface YDGCDClass : NSOperation

- (void) start;
- (void) finished;
@property BOOL isExecuting, isFinished;

@end

@implementation YDGCDClass

// Note, you don't need to @synthesize isExecuting, isFinished!
- (void) setNotification {
    NSLog(@"[+] isFinished() Observer setting");

    [[NSNotificationCenter defaultCenter] addObserverForName:@"isFinished" object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         NSLog(@"[+] %@ COMPLETED\n", note.name);
     }];
}

- (void)start
{
    self.isExecuting = YES;
    self.isFinished = NO;
    NSLog(@"[+] [YDGCDClass start] on Main thread? %@", [NSThread isMainThread] ? @"Yes" : @"No");
    NSLog(@"[+] [YDGCDClass start] isExecuting? %@", self.isExecuting ? @"Yes" : @"No");
    uint64_t tid;
    assert(pthread_threadid_np(NULL, &tid)== 0);
    NSLog(@"[+] Thread ID: %#08x", (unsigned int) tid);

    for(int i = 0; i < 2; i++)
    {
        sleep(1);
    }
    [self finished];
}

- (void)finished
{
    self.isExecuting = NO;
    self.isFinished = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isFinished" object:self userInfo:nil];
}

@end

int main() {
    @autoreleasepool {

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        YDGCDClass *operation = [[YDGCDClass alloc] init];

        operation.queuePriority = NSOperationQueuePriorityLow;
        operation.qualityOfService = NSOperationQualityOfServiceBackground;

        [operation setNotification];
        [queue addOperation:operation];

        [queue waitUntilAllOperationsAreFinished];      // stop main thread from finishing
    }

    return 0;
}

/*
  [+] [YDGCDClass start] on Main thread? No
  [+] [YDGCDClass start] isExecuting? Yes
  [+] Thread ID: 0x0d61b5
  [+] isFinished COMPLETED
*/
