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

@interface YDFishClass : NSObject
{
    int _count;
    NSString *_name;
}
@property int count;
@property NSString *name;
@end

@implementation YDFishClass
@synthesize count = _count;
@synthesize name = _name;

@end

typedef void (^SimpleSlowBlock)(YDFishClass *);

SimpleSlowBlock simpleBlock = ^ (YDFishClass *fishObj){

    NSLog(@"[+] simpleBlock on Main thread: %@", [NSThread isMainThread] ? @"Yes" : @"No");
    NSTimeInterval blockThreadTimer = 0.5;

    uint64_t tid;
    assert(pthread_threadid_np(NULL, &tid)== 0);
    NSLog(@"[+]%@: thread ID: %#08x", [fishObj name], (unsigned int) tid);

    for(int i = 0; i < 3; i++)
    {
        NSLog(@"\t\t%@", [fishObj name]);
        [NSThread sleepForTimeInterval:blockThreadTimer];
    }
};


int main() {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {

            YDFishClass *shark = [[YDFishClass alloc] init];
            shark.count = 5;
            shark.name = @"Tiger Shark";

            simpleBlock(shark);
        }

        dispatch_semaphore_signal(semaphore);
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {

            YDFishClass *jellyfish = [[YDFishClass alloc] init];
            jellyfish.count = 5;
            jellyfish.name = @"Man O' War";

            simpleBlock(jellyfish);
        }
        dispatch_semaphore_signal(semaphore);
    });

    // Wait for the above block execution.
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return 0;
}
/*
[+] simpleBlock on Main thread: No
[+] simpleBlock on Main thread: No
[+]Man O' War: thread ID: 0x023b1a
[+]Tiger Shark: thread ID: 0x023b1b
		Man O' War
		Tiger Shark
		Man O' War
		Tiger Shark
		Man O' War
		Tiger Shark
Program ended with exit code: 0
*/
