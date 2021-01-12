@import Foundation;

#define FRIDA_DEFAULT 27042
#define KILL_TIMER 40

static NSString *YDhostname = @"127.0.0.1";
static NSUInteger const YDstartPort = 2000;
static NSUInteger const YDendPort = 3000;

/*
    https://stackoverflow.com/questions/5157005/ios-nssocketport-where-art-thou
    https://gist.github.com/rjungemann/446256
 */

@interface YDbarSockets : NSObject <NSStreamDelegate>
@end

@implementation YDbarSockets

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;


- (instancetype) init {
    self = [super init];
    if (self) {
        NSLog(@"Starting init");
        NSURL *url = [NSURL URLWithString:YDhostname];
        NSLog(@"Setting up connection to %@ : %lu", [url absoluteString], (unsigned long)YDstartPort);
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (CFStringRef)[url host], YDstartPort, &readStream, &writeStream);
        
        if(!CFWriteStreamOpen(writeStream)) {
            NSLog(@"Error, writeStream not open");
        }
        
        inputStream = (NSInputStream *)readStream;
        outputStream = (NSOutputStream *)writeStream;
        [inputStream setDelegate:self];
        [outputStream setDelegate:self];
        
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [inputStream open];
        NSLog(@"streamStatus %lu", (unsigned long)[inputStream streamStatus]);
    }
    return self;
}

@end


int main(void) {
    @autoreleasepool{
        YDbarSockets *socketChecker = [[YDbarSockets alloc] init];

    }
    return 0;
}

