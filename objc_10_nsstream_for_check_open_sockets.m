@import Foundation;

#define FRIDA_DEFAULT 27042
#define KILL_TIMER 40

static NSString *YDhostname = @"127.0.0.1";
static NSUInteger const YDstartPort = 2015;
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


- (void) setup {

    NSLog(@"Starting init");
    NSURL *url = [NSURL URLWithString:YDhostname];
    NSLog(@"Setting up connection to %@ : %lu", [url absoluteString], (unsigned long)YDstartPort);
    
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                       (CFStringRef) [url host],
                                       YDstartPort,
                                       &readStream,
                                       &writeStream);
    
    if(!CFWriteStreamOpen(writeStream)) {
        NSLog(@"Error, writeStream not open");
    }
    
    inputStream = (NSInputStream *)readStream;
    outputStream = (NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    NSLog(@"streamStatus %lu", (unsigned long)[inputStream streamStatus]);
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    NSLog(@"Stream is sending an Event: %lu", (unsigned long)eventCode);
}

- (void) close {
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

@end


int main(void) {
    @autoreleasepool{
        YDbarSockets *socketChecker = [[YDbarSockets alloc] init];
        [socketChecker setup];
        [socketChecker close];
