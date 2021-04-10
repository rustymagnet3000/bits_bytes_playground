#import <Foundation/Foundation.h>
#include <objc/message.h>

@interface YDStockHolding : NSObject
{
    float _purchaseSharePrice;
    float _currentSharePrice;
    int _numberOfShares;
    NSString *_shareHolder;
}

- (id)initWithName:(NSString *)name;
- (float) costInGBP;
- (float) valueInGBP;

@property float purchaseSharePrice, currentSharePrice;
@property int numberOfShares;
@property NSString *shareHolder;

@end

@implementation YDStockHolding

- (id)initWithName:(NSString *)name
{
    _shareHolder = name;
    return self;
}

-(float) costInGBP
{
    return _purchaseSharePrice * _numberOfShares;
}

-(float) valueInGBP
{
    return _currentSharePrice * _numberOfShares;
}
@synthesize purchaseSharePrice = _purchaseSharePrice,
currentSharePrice = _currentSharePrice,
numberOfShares = _numberOfShares,
shareHolder = _shareHolder;
@end


int main() {
    @autoreleasepool {

        YDStockHolding *stock = [[YDStockHolding alloc] initWithName:@"Jon Snow"];

        [stock setPurchaseSharePrice:1.41];
        [stock setCurrentSharePrice:1.71];
        [stock setNumberOfShares:1000];
        [stock setShareHolder:@"Night King"];

        Class myClass = [stock class];
        Class mySuperClass = class_getSuperclass(myClass);
        NSLog(@"[+]%@ is the Superclass of %@", NSStringFromClass(mySuperClass), NSStringFromClass(myClass));

        SEL purchaseSel = @selector(purchaseSharePrice);
        SEL initSel = @selector(initWithName:);

        Method myGetMethod = class_getInstanceMethod([stock class], purchaseSel);
        Method mySetMethod = class_getInstanceMethod([stock class], initSel);

        NSLog(@"[+]%@ arguments: %u", NSStringFromSelector(purchaseSel), method_getNumberOfArguments(myGetMethod));
        NSLog(@"[+]%@# arguments: %u", NSStringFromSelector(initSel), method_getNumberOfArguments(mySetMethod));

        if ([stock respondsToSelector:@selector(purchaseSharePrice)]) {
            NSLog(@"[+]respondsToSelector for PurchaseSharePrice");
        }

        if (![stock respondsToSelector:@selector(foobar)]) { // compiler warning "Undeclared selector 'foobar'"
            NSLog(@"[+]calling foobar @selector would cause a crash");
        }

        float (*objc_msgSendTyped)(id self, SEL _cmd) = (void*)objc_msgSend;
        float money = objc_msgSendTyped(stock, @selector(valueInGBP));

        objc_msgSend(stock, @selector(initWithName:),@"Tyrion Lannister");

        NSLog(@"[+]%@ has :£%.2f", [stock shareHolder], money);
        NSLog(@"[+]%@'s profit: £%.2f\n\n",[stock shareHolder],[stock valueInGBP] - [stock costInGBP]);
    }
    return 0;
}
