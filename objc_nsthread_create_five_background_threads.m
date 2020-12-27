#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif
#define MAX_THREADS 5
#define KILL_TIMER 6
@import Foundation;
#include <pthread.h>

/* https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/CreatingThreads/CreatingThreads.html */
@implementation FoobarThreads:NSObject

-(instancetype)init{
    self = [super init];
    if (self) {
        NSThread* myThread = [[NSThread alloc]  initWithTarget:self
                                                selector:@selector(sleepingMethod)
                                                object:nil];
        [myThread start];

    }
    return self;
}

-(NSString *)getThreadID{
    uint64_t tid;
    pthread_threadid_np(NULL, &tid);
    NSString *tidStr = [[NSString alloc] initWithFormat:@"%#08x", (unsigned int) tid];
    return tidStr;
}

-(void)sleepingMethod{
    NSTimeInterval intervalToSleep = 20.0;
    NSLog (@"[*]Thread ID: %@", [self getThreadID]);
    [NSThread sleepForTimeInterval:intervalToSleep];
}

@end


int main(void) {
    
    @autoreleasepool{

        [[NSThread mainThread] setName:@"The main thread"];
        NSLog (@"[*]Am I multi-threaded? \t%@", [NSThread isMultiThreaded] == 0 ?  @"YES" : @"NO");
        NSLog (@"[*]Am I the main thread?\t%@", [NSThread isMainThread] == 1 ?  @"YES" : @"NO");
        
        for (ushort i = 0; i < MAX_THREADS; i++) {
            __unused FoobarThreads *newObjectWithThread = [FoobarThreads new];
        }
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        NSDate *startPlusKillTimer = [currentCalendar dateByAddingUnit:NSCalendarUnitSecond
                                                                   value:KILL_TIMER
                                                                  toDate:[NSDate date]
                                                                 options:NSCalendarMatchNextTime];
        [runLoop runUntilDate:startPlusKillTimer];
        NSLog (@"[*]Auto-release about to fire");

    }
    return 0;
}


/* 
	[*]Am I multi-threaded? 	YES
	[*]Am I the main thread?	YES
	[*]Thread ID: 0x4ef7ab
	[*]Thread ID: 0x4ef7ac
	[*]Thread ID: 0x4ef7ad
	[*]Thread ID: 0x4ef7ae
	[*]Thread ID: 0x4ef7af
	[*]Auto-release about to fire
	Program ended with exit code: 0
*/
