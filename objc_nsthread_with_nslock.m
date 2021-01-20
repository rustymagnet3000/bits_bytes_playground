#define MAX_THREADS 5
#define KILL_TIMER 6
@import Foundation;
#include <pthread.h>
#include <mach/mach.h>
#include <err.h>

/*
    The last example could cause a runtime exception on `[_pets removeLastObject];`
    It happened when aanother thread had already removed the last object so the pets count was at 0
 */

@interface FoobarThreads : NSObject
    @property (class, nonatomic, strong) NSMutableArray *pets;
@end

@implementation FoobarThreads

 NSLock *arrayLock = nil;
 static NSMutableArray *_pets;

+ (NSMutableArray *)pets{
    return _pets;
}

+(void)setPets:(NSMutableArray *)newPet{
    _pets = newPet;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        NSThread* thread = [[NSThread alloc]  initWithTarget:self
                                                selector:@selector(setThreadNameThenSleep)
                                                object:nil];
        [thread setThreadPriority:0.20];
        [thread start];
    }
    return self;
}

-(NSString *)getThreadID{
    uint64_t tid;
    pthread_threadid_np(NULL, &tid);
    NSString *tidStr = [[NSString alloc] initWithFormat:@"%#08x", (unsigned int) tid];
    return tidStr;
}

-(void)setThreadNameThenSleep{
    NSTimeInterval intervalToSleep = 20.0;
    
    [arrayLock lock];
    NSString *threadName = [_pets lastObject];
    threadName == nil ?  threadName = @"Panda" : [_pets removeLastObject];
    [arrayLock unlock];
    [[NSThread currentThread] setName:threadName];
    NSLog (@"[*]Thread name:\t%@   \t\tID: %@", [[NSThread currentThread] name], [self getThreadID]);
    [NSThread sleepForTimeInterval:intervalToSleep];
}

@end


int main(void) {
    
    @autoreleasepool{

        [FoobarThreads setPets:[NSMutableArray arrayWithObjects:@"Dog   ", @"Cat   ", @"Baboon", @"Fish  ", nil]];
        NSLog(@"Pets\t %@", FoobarThreads.pets);
        
        [[NSThread mainThread] setName:@"The main thread"];

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
    }
    return 0;
}
