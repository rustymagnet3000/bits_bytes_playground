#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif
#define MAX_THREADS 5
#define KILL_TIMER 6
@import Foundation;
#include <pthread.h>
#include <mach/mach.h>

@interface FoobarThreads : NSObject
    @property (class, nonatomic, strong) NSMutableArray *pets;
@end

@implementation FoobarThreads

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
    NSString *threadName = [_pets lastObject];
    threadName == nil ?  threadName = @"Panda" : [_pets removeLastObject];
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


    }
    return 0;
}



/* 
Pets	 (
    "Dog   ",
    "Cat   ",
    Baboon,
    "Fish  "
)
[*]Am I multi-threaded? 	YES
[*]Am I the main thread?	YES
[*]Thread name:	Fish     		ID: 0x592f86
[*]Thread name:	Baboon   		ID: 0x592f89
[*]Thread name:	Dog      		ID: 0x592f8a
[*]Thread name:	Cat      		ID: 0x592f88
[*]Thread name:	Panda   		ID: 0x592f87
Program ended with exit code: 0
*/
