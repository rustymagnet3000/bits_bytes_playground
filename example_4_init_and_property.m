#import <Foundation/Foundation.h>

@interface Appliance : NSObject {
    NSString *productName;
    int voltage;
}
@property (copy) NSString *productName;
@property int voltage;

@end

@implementation Appliance

@synthesize productName, voltage;
- (id)init{
    self = [super init];
    if (self) { // done based on Apple guidelines
        [self setVoltage: 180]; // nicer pattern than `voltage = 180`
    }
    return self;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Appliance *appliance = [[Appliance alloc] init];
        NSLog(@"Voltage default value: %d", appliance.voltage);
        [appliance setVoltage:150];
        NSLog(@"Property gives you a setter & getter: %d", appliance.voltage);

    }
    return 0;
}
