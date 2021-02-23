#import <Foundation/Foundation.h>
#define DEFAULT_WIDTH 30
#define KILL_TIMER 5
#define PROGRESS_CHAR '-'
#include <sys/ioctl.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@interface YDPrettyConsole : NSObject

@property BOOL running;

+ (void)banner;

@end

@implementation YDPrettyConsole : NSObject

static int width;
int curser_counter;

- (instancetype)init{
        self = [super init];
        if (self) {
             [self setNotification];
             self.running = TRUE;
             dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
             dispatch_async(dispatchQueue, ^{
                 [self UIProgressStart];
             });
        }
    return self;
}

- (void) UIProgressStart{

    while (self.running == TRUE) {
        if(curser_counter == width){
            curser_counter = 0;
            putchar('\n');
        }
        curser_counter++;
        putchar(PROGRESS_CHAR);
        usleep(750000); // 0.25
    }
    #pragma mark - complete search banner.
    for (; curser_counter < width; curser_counter++){
        putchar(PROGRESS_CHAR);
    }
    putchar('\n');
}

- (void)setNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"LoopFinished" object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         [self receiveNotification:note];
     }];
}

-(void) receiveNotification:(NSNotification*)notification
{
    if ([notification.name isEqualToString:@"LoopFinished"])
    {
        [self setRunning:FALSE];
    }
}

+ (void)banner{

    if(width == 0) {
        struct winsize w;
        ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
        if(w.ws_row > 0) {
            width = w.ws_col;
        } else {
            width = DEFAULT_WIDTH;
        }
    }
    for (int i = 0; i < width; i++)
        putchar('*');
    putchar('\n');
}


@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        [YDPrettyConsole banner];
        __unused YDPrettyConsole *progressBar = [[YDPrettyConsole alloc] init];
        for (int i = 0; i < 4; i++) {
            sleep(1);
        }
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoopFinished" object:NULL userInfo:nil];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];

        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        
        NSDate *startPlusKillTimer = [currentCalendar dateByAddingUnit:NSCalendarUnitSecond
                                                                   value:KILL_TIMER
                                                                  toDate:[NSDate date]
                                                                 options:NSCalendarMatchNextTime];
        [runLoop runUntilDate:startPlusKillTimer];
        
        NSLog(@"runLoop expired");
    }
    return 0;
}

