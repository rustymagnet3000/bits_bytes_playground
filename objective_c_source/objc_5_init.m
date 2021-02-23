#import <Foundation/Foundation.h>

@interface Appliance : NSObject {
    NSString *productName;
    int voltage;
}
@property (copy) NSString *productName;
@property int voltage;
- (id) initWithProductName: (NSString *)pn; // the designated initializer
@end

@implementation Appliance

@synthesize productName, voltage;

- (id) initWithProductName: (NSString *)pn{
    self = [super init];
    if (self) {
        [self setProductName:pn];
        [self setVoltage: 180];
    }
    return self;
}
- (NSString *) description{
    return [NSString stringWithFormat:@"<%@: %d volts>", productName, voltage];
}

- (id)init{
    return [self initWithProductName:@"unknown"];
}
@end

@interface OwnedAppliance : Appliance {
    NSMutableSet *ownerNames;
}
- (id) initWithProductName:(NSString *)pn firstOwnerName: (NSString *)n; // the designated initializer
- (void)addOwnerNamesObject:(NSString *)n;
- (void)removeOwnerNamesObject:(NSString *)n;
@end

@implementation OwnedAppliance

- (id) initWithProductName:(NSString *)pn firstOwnerName: (NSString *)n{
    self = [super initWithProductName:pn];
    if (self) {
        ownerNames = [[NSMutableSet alloc] init];
        if (n) {
            [ownerNames addObject:n];
        }
    }
    return self;  // return pointer to new object
}

- (id) initWithProductName: (NSString *)pn{
    // this methods ensures you set Owner Name to nil
    // OwnedAppliance *a = [[OwnedAppliance alloc] initWithProductName:@"toaster"];
    return [self initWithProductName:pn firstOwnerName:nil];
}

- (void) addOwnerNamesObject:(NSString *)n
{
    [ownerNames addObject:n];
}

- (void) removeOwnerNamesObject:(NSString *)n
{
    [ownerNames removeObject:n];
}

- (NSString *) description{
    return [NSString stringWithFormat:@"<%@: %d volts>Owner: %@", productName, voltage, ownerNames];
}
@end
/******************************************************************/
/******************************************************************/

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Appliance *a = [[Appliance alloc] initWithProductName:@"doozie"];
        NSLog(@"a = %@", a);
        OwnedAppliance *b = [[OwnedAppliance alloc] initWithProductName:@"toaster"];
        NSLog(@"b = %@", b);
        OwnedAppliance *c = [[OwnedAppliance alloc] initWithProductName:@"oven" firstOwnerName:@"Dr Pants"];
        NSLog(@"c = %@", c);
        [c setVoltage:99];
        [c addOwnerNamesObject: @"Prof Shorts"];
        NSLog(@"c = %@", c);
        [c removeOwnerNamesObject:@"Dr Pants"];
        NSLog(@"c = %@", c);
    }
    return 0;
}
