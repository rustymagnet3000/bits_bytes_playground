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

NSMutableArray *fishyArray;
NSLock *arrayLock;

@interface YDFishClass : NSObject
{
    NSInteger _caught;
    NSString *_name;
}
@property NSInteger caught;
@property NSString *name;
@end

@implementation YDFishClass
@synthesize caught = _caught;
@synthesize name = _name;

@end

typedef void (^SimpleSlowBlock)(YDFishClass *);

SimpleSlowBlock simpleBlock = ^ (YDFishClass *fishObj){

    NSTimeInterval blockThreadTimer = 0.2;
    uint64_t tid;
    assert(pthread_threadid_np(NULL, &tid)== 0);
    NSLog(@"[+]%@: thread ID: %#08x", [fishObj name], (unsigned int) tid);

    for(int i = 0; i <= [fishObj caught]; i++)
    {
        [arrayLock lock]; // NSMutableArray isn't thread-safe
        [fishyArray addObject:[fishObj name]];
        [arrayLock unlock];
        [NSThread sleepForTimeInterval:blockThreadTimer];
    }
};


void yd_start_stop(void) {

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            YDFishClass *shark = [[YDFishClass alloc] init];
            shark.caught = 5;
            shark.name = @"Tiger Shark";
            simpleBlock(shark);
        }

        dispatch_semaphore_signal(semaphore);
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            YDFishClass *jellyfish = [[YDFishClass alloc] init];
            jellyfish.caught = 5;
            jellyfish.name = @"Lemon Shark";
            simpleBlock(jellyfish);
        }
        dispatch_semaphore_signal(semaphore);
    });

    // Wait for the above block execution.
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

}


int main(void) {

    @autoreleasepool {
        fishyArray = [[NSMutableArray alloc] init];
        arrayLock = [[NSLock alloc] init];
        yd_start_stop();
        [arrayLock lock];

        [fishyArray enumerateObjectsUsingBlock: ^(NSString *string, NSUInteger index, BOOL *stop){
            NSLog(@"%@: %lu", string, (unsigned long)index);
        }];
        [arrayLock unlock];
    };

    return 0;
}

/*
[+]Tiger Shark: thread ID: 0x0dd5a5
[+]Lemon Shark: thread ID: 0x0dd5a6
Tiger Shark: 0
Lemon Shark: 1
Tiger Shark: 2
Lemon Shark: 3
Tiger Shark: 4
Lemon Shark: 5
Tiger Shark: 6
Lemon Shark: 7
Tiger Shark: 8
Lemon Shark: 9
Tiger Shark: 10
Lemon Shark: 11
*/
