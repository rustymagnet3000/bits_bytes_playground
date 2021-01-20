#define MAX_THREADS 5
#define THREAD_NAME_MAX 10
#define KILL_TIMER 2
@import Foundation;
#include <pthread.h>
#include <mach/mach.h>
#include <err.h>

/*
    Calls into the Kernal for Thread List:  task_threads(mach_task_self(), &thread_list, &thread_count);
 
    There is still a runtime exception on `[_pets removeLastObject];`
 
    It happens when another thread had already removed the last object so the pets count was at 0
 
    The NSLock is nil at point of crash
 
    https://www.mikeash.com/pyblog/friday-qa-2015-02-20-lets-build-synchronized.html
    https://stackoverflow.com/questions/15401363/retrieve-thread-name-in-ios-of-non-current-thread
 
 
    I moved to using @synchronized(_pets) into of NSLocks.  No repeat crash, as yet.
 
 */

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
    NSString *tidStr = [[NSString alloc] initWithFormat:@"🐝%#08x", (unsigned int) tid];
    return tidStr;
}

-(void)setThreadNameThenSleep{
    NSTimeInterval intervalToSleep = 20.0;
    
    @synchronized(_pets) {
        NSString *threadName = [_pets lastObject];
        threadName == nil ?  threadName = @"Panda" : [_pets removeLastObject];
        [[NSThread currentThread] setName:threadName];
    }
    NSLog (@"[*]Thread name:\t%@   \t\tID: %@", [[NSThread currentThread] name], [self getThreadID]);
    [NSThread sleepForTimeInterval:intervalToSleep];
}

@end


int main(void) {
    
    @autoreleasepool{

        [FoobarThreads setPets:[NSMutableArray arrayWithObjects:@"Dog   ", @"Cat   ", @"Baboon", @"Fish  ", nil]];
       
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
        
        /*******************************************/
        /**          task_threads                  */
        /*******************************************/
        
        thread_act_array_t thread_list;
        mach_msg_type_number_t thread_count = 0;
        const task_t    this_task = mach_task_self();
        const thread_t  this_thread = mach_thread_self();
        
        kern_return_t kr = task_threads(mach_task_self(), &thread_list, &thread_count);
        if (kr != KERN_SUCCESS)
            NSLog(@"error getting task_threads: %s\n", mach_error_string(kr));

        char name[THREAD_NAME_MAX];
        
        if (thread_count > 2){
            for (int i = 0; i < thread_count; i++){
                pthread_t pt = pthread_from_mach_thread_np(thread_list[i]);
                if (pt) {
                    name[0] = '\0';
                    __unused int rc = pthread_getname_np (pt, name, sizeof name);
                    uint64_t tid;
                    pthread_threadid_np(pt, &tid);
                    NSLog(@"🐝mach thread %u\t\ttid:%#08x\t\t%s", thread_list[i], (unsigned int) tid, name[0] == '\0' ?  "<None>" : name);
                }
                else
                    NSLog(@"mach thread %u: no pthread found", thread_list[i]);
            }
        }
        mach_port_deallocate(this_task, this_thread);
        vm_deallocate(this_task, (vm_address_t)thread_list, sizeof(thread_t) * thread_count);
    }
    return 0;
}


/*
2020-12-30 12:36:26.857008+0000 objc_play[2508:6556039] [*]Thread name:	Panda		ID: 🐝0x640987
2020-12-30 12:36:26.857008+0000 objc_play[2508:6556040] [*]Thread name:	Baboon		ID: 🐝0x640988
2020-12-30 12:36:26.857008+0000 objc_play[2508:6556041] [*]Thread name:	Dog   		ID: 🐝0x640989
2020-12-30 12:36:26.857062+0000 objc_play[2508:6556037] [*]Thread name:	Fish  		ID: 🐝0x640985
2020-12-30 12:36:26.858919+0000 objc_play[2508:6556038] [*]Thread name:	Cat   		ID: 🐝0x640986
2020-12-30 12:36:28.866305+0000 objc_play[2508:6555670] 🐝mach thread 775		tid:0x640816	< Main thread >
2020-12-30 12:36:28.866444+0000 objc_play[2508:6555670] 🐝mach thread 3587		tid:0x640984	< not named >
2020-12-30 12:36:28.866543+0000 objc_play[2508:6555670] 🐝mach thread 4099		tid:0x640985	Fish  
2020-12-30 12:36:28.866638+0000 objc_play[2508:6555670] 🐝mach thread 3843		tid:0x640986	Cat   
2020-12-30 12:36:28.866711+0000 objc_play[2508:6555670] 🐝mach thread 5379		tid:0x640987	Panda
2020-12-30 12:36:28.866765+0000 objc_play[2508:6555670] 🐝mach thread 5891		tid:0x640988	Baboon
2020-12-30 12:36:28.866816+0000 objc_play[2508:6555670] 🐝mach thread 6403		tid:0x640989	Dog   
2020-12-30 12:36:28.866892+0000 objc_play[2508:6555670] 🐝mach thread 17667		tid:0x64098a	< not named >
