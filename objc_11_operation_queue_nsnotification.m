@import Foundation;
#include <pthread.h>
#include <mach/mach.h>
#include <err.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

#define MAX_THREADS 5
#define THREAD_NAME_MAX 10
#define KILL_TIMER 2


/*   Open Ports are stored in a Class NSMutableArray ( singleton )      */
/*   Class inherits from NSOperation                                    */
/*   The Class represents the smallest unit of work ( the Operation )   */
/*   Each Operation is added to a single NSOperationQueue               */
/*   After each Operation is finished, it publishes a Notification      */


static NSString *YDhostname = @"127.0.0.1";
static NSUInteger YDstartPort = 10;
static NSUInteger const YDendPort = 100;

@interface YDOperation : NSOperation

- (void) start;
- (void) finished;

@property (nonatomic, assign) NSUInteger port;
@property (nonatomic, assign)  BOOL isExecuting, isFinished;
@property (class, nonatomic, strong) NSMutableArray *openPorts;

@end

@implementation YDOperation

static NSMutableArray *_openPorts;

+ (NSMutableArray *)openPorts{
   return _openPorts;
}

+(void)setOpenPorts:(NSMutableArray *)ports{
    _openPorts = ports;
}

- (void) setNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"foobar" object:self queue:nil usingBlock:^(NSNotification *note)
     {
        NSLog(@"[+] %lu complete", (unsigned long)self.port);
     }];
}

-(instancetype)init:(NSUInteger)enteredPort {
    self = [super init];
    if (self) {
        _port = enteredPort;
        return self;
    }
    return nil;
}
    

- (void)start {
    self.isExecuting = YES;
    self.isFinished = NO;
    NSLog(@"starting %lu", (unsigned long)self.port);
    
    if (_port % 3 == 0) {
        [_openPorts addObject:[NSNumber numberWithInt:_port]];
    }
    [self finished];
}

- (void)finished {
    self.isExecuting = NO;
    self.isFinished = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"foobar" object:self userInfo:nil];
}

@end

int main() {
    @autoreleasepool {

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [YDOperation setOpenPorts: [NSMutableArray array]];
        
        do {
            YDOperation *operation = [[YDOperation alloc] init:YDstartPort];
            operation.queuePriority = NSOperationQueuePriorityNormal;
            operation.qualityOfService = NSOperationQualityOfServiceUserInteractive;
            [queue addOperation:operation];
            [operation setNotification];
            YDstartPort++;
        } while (YDstartPort < YDendPort);
        
        [queue waitUntilAllOperationsAreFinished];      // stop main thread from finishing
        NSLog(@"Open Ports %@", [YDOperation openPorts]);
    }

    return 0;
}



/*
 starting 10
 [+] 10 complete
 starting 12
 starting 11
 [+] 12 complete
 starting 14
 [+] 14 complete
 [+] 11 complete
 starting 15
 starting 13
 starting 16
 [+] 15 complete
 [+] 16 complete
 [+] 13 complete
 starting 17
 starting 18
 [+] 17 complete
 [+] 18 complete
 starting 21
 [+] 21 complete
 starting 20
 starting 23
 starting 19
 [+] 23 complete
 starting 22
 [+] 22 complete
 [+] 20 complete
 [+] 19 complete
 starting 25
 starting 26
 [+] 25 complete
 [+] 26 complete
 starting 24
 [+] 24 complete
 starting 29
 starting 27
 starting 28
 [+] 27 complete
 [+] 28 complete
 [+] 29 complete
 starting 31
 starting 32
 [+] 31 complete
 [+] 32 complete
 starting 30
 starting 34
 [+] 30 complete
 starting 33
 starting 35
 [+] 34 complete
 starting 36
 [+] 35 complete
 [+] 33 complete
 starting 37
 [+] 36 complete
 [+] 37 complete
 starting 40
 starting 38
 [+] 40 complete
 starting 39
 [+] 38 complete
 starting 41
 [+] 39 complete
 [+] 41 complete
 starting 42
 [+] 42 complete
 starting 43
 starting 44
 [+] 43 complete
 starting 45
 [+] 44 complete
 starting 46
 [+] 45 complete
 starting 47
 [+] 46 complete
 starting 48
 starting 50
 [+] 48 complete
 [+] 50 complete
 starting 52
 starting 49
 [+] 47 complete
 [+] 49 complete
 starting 54
 [+] 52 complete
 [+] 54 complete
 starting 53
 starting 51
 [+] 53 complete
 [+] 51 complete
 starting 56
 starting 55
 [+] 55 complete
 starting 57
 [+] 57 complete
 starting 58
 starting 59
 starting 60
 [+] 59 complete
 [+] 58 complete
 [+] 60 complete
 starting 61
 [+] 61 complete
 starting 62
 starting 63
 starting 64
 starting 65
 [+] 62 complete
 starting 66
 [+] 65 complete
 [+] 64 complete
 [+] 66 complete
 starting 70
 starting 69
 starting 72
 starting 73
 starting 74
 starting 75
 [+] 72 complete
 [+] 73 complete
 starting 76
 starting 77
 [+] 76 complete
 starting 79
 starting 80
 starting 81
 starting 83
 [+] 81 complete
 [+] 79 complete
 [+] 83 complete
 starting 86
 starting 88
 starting 90
 [+] 86 complete
 starting 91
 starting 94
 starting 93
 starting 96
 [+] 94 complete
 starting 97
 [+] 93 complete
 [+] 97 complete
 [+] 96 complete
 starting 98
 starting 68
 starting 67
 [+] 67 complete
 [+] 98 complete
 [+] 69 complete
 [+] 74 complete
 starting 78
 [+] 77 complete
 starting 82
 [+] 78 complete
 [+] 80 complete
 starting 85
 starting 89
 [+] 88 complete
 starting 92
 [+] 90 complete
 [+] 89 complete
 [+] 91 complete
 [+] 92 complete
 [+] 63 complete
 [+] 68 complete
 starting 71
 [+] 70 complete
 [+] 75 complete
 starting 84
 starting 87
 [+] 85 complete
 [+] 82 complete
 starting 95
 starting 99
 [+] 71 complete
 [+] 84 complete
 [+] 87 complete
 [+] 99 complete
 [+] 95 complete
 Open Ports (
     12,
     15,
     18,
     21,
     24,
     27,
     30,
     33,
     36,
     39,
     42,
     45,
     48,
     54,
     51,
     57,
     60,
     63,
     66,
     69,
     72,
     75,
     81,
     90,
     93,
     96,
     78,
     84,
     87,
     99
 )
 */

