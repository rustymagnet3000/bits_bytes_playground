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

2020-12-29 16:21:05.619319+0000 objc_play[95385:6467089] [*]Thread name:	Baboon   		ID: 🐝0x62ae11
2020-12-29 16:21:05.619322+0000 objc_play[95385:6467091] [*]Thread name:	Panda   		ID: 🐝0x62ae13
2020-12-29 16:21:05.619331+0000 objc_play[95385:6467088] [*]Thread name:	Fish     		ID: 🐝0x62ae10
2020-12-29 16:21:05.619323+0000 objc_play[95385:6467092] [*]Thread name:	Dog      		ID: 🐝0x62ae14
2020-12-29 16:21:05.621409+0000 objc_play[95385:6467090] [*]Thread name:	Cat      		ID: 🐝0x62ae12
2020-12-29 16:21:07.629013+0000 objc_play[95385:6466711] 🐝mach thread 775		tid:0x62ac97		The main 
2020-12-29 16:21:07.629159+0000 objc_play[95385:6466711] 🐝mach thread 4611		tid:0x62ae0f		<None>
2020-12-29 16:21:07.629226+0000 objc_play[95385:6466711] 🐝mach thread 3843		tid:0x62ae10		Fish  
2020-12-29 16:21:07.629283+0000 objc_play[95385:6466711] 🐝mach thread 4099		tid:0x62ae11		Baboon
2020-12-29 16:21:07.629420+0000 objc_play[95385:6466711] 🐝mach thread 10499		tid:0x62ae12		Cat   
2020-12-29 16:21:07.629540+0000 objc_play[95385:6466711] 🐝mach thread 10243		tid:0x62ae13		Panda
2020-12-29 16:21:07.629720+0000 objc_play[95385:6466711] 🐝mach thread 9987		tid:0x62ae14		Dog   
2020-12-29 16:21:07.629800+0000 objc_play[95385:6466711] 🐝mach thread 15363		tid:0x62ae15		<None>
Program ended with exit code: 0
*/
