#import <Foundation/Foundation.h>

@interface StockHolding : NSObject
{
    float _purchaseSharePrice;
    float _currentSharePrice;
    int _numberOfShares;
}
- (float) costInDollars;
- (float) valueInDollars;

@property float purchaseSharePrice, currentSharePrice;
@property int numberOfShares;

@end

@implementation StockHolding
-(float) costInDollars
{
    return _purchaseSharePrice * _numberOfShares;
}

-(float) valueInDollars
{
    return _currentSharePrice * _numberOfShares;
}
@synthesize purchaseSharePrice = _purchaseSharePrice,
                currentSharePrice = _currentSharePrice,
                    numberOfShares = _numberOfShares;
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *stockList = [NSMutableArray array];

        StockHolding *stock1 = [[StockHolding alloc] init];
        StockHolding *stock2 = [[StockHolding alloc] init];

        stock1.purchaseSharePrice = 2;
        stock1.currentSharePrice = 1;
        stock1.numberOfShares = 10;
        [stockList addObject:stock1];

        stock2.purchaseSharePrice = 3;
        stock2.currentSharePrice = 4;
        stock2.numberOfShares = 5;
        [stockList addObject:stock2];


        for (int i = 0; i < [stockList count]; i++) {
            NSLog(@"[+] Share index %d ", i);
            NSLog(@"[+] Value of holding: %.2f ",[stockList[i] valueInDollars]);
            NSLog(@"[+]  Profit: %.2f", [stockList[i] valueInDollars] - [stockList[i] costInDollars]);
        }
    }
    return 0;
}
