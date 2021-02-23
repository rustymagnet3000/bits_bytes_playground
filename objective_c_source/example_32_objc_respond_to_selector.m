#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

#import <Foundation/Foundation.h>


@interface StockHolding : NSObject
{
    float _purchaseSharePrice;
    float _currentSharePrice;
    int _numberOfShares;
}
- (float) valueInDollars;

@property float purchaseSharePrice, currentSharePrice;
@property int numberOfShares;

@end

@implementation StockHolding

+(NSString *) shareName
{
    return  @"RM's Favourite Share";
}

-(float) valueInDollars
{
    return _currentSharePrice * _numberOfShares;
}
@synthesize purchaseSharePrice = _purchaseSharePrice,
                currentSharePrice = _currentSharePrice,
                    numberOfShares = _numberOfShares;
@end

int main() {
    @autoreleasepool {

        StockHolding *stock1 = [[StockHolding alloc] init];
        stock1.purchaseSharePrice = 2;
        stock1.currentSharePrice = 1;
        stock1.numberOfShares = 10;

        SEL valueMethod = @selector(valueInDollars);
        SEL shareNameMethod = @selector(shareName);
        
        if ([stock1 respondsToSelector:valueMethod] == true){
            NSLog(@"%@:\n\t selector responded %@", NSStringFromSelector(valueMethod), [stock1 self]);
        }
        
        if ([StockHolding respondsToSelector:shareNameMethod] == true){
            NSLog(@"%@:\n\t selector responded. Static method in: %@", NSStringFromSelector(shareNameMethod), [StockHolding self]);
        }
    }
    return 0;
}

/* OUTPUT:
 
 valueInDollars:
      selector responded <StockHolding: 0x1007029f0>
 shareName:
      selector responded. Static method in: StockHolding
 */

