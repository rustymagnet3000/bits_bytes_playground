
# Instrument FizzBuzz
Xcode's `Instruments` was an amazing tool. It leveraged `Dtrace` to watch everything inside an app.

I used the child's game / developer question `Fizz Buzz` to show the speed differences.

> Write a short program that prints each number from 1 to 100 on a new line.
>
> For each multiple of 3, print "Fizz" instead of the number.
>
> For each multiple of 5, print "Buzz" instead of the number.
>
> For numbers which are multiples of both 3 and 5, print "FizzBuzz" instead of the number.

I changed the count to 1 million.

You could use `Time Profiler` inside of `Instruments` to observe speed differences in languages - `Objc`, `Swift` and `C`.  It was easy to see the code or system API call that caused delay.

Language | Speed | Info
--|--|--
Objective-C  | 27 - 34 seconds  | Delay caused by a function call with a slow loop.
Objective-C  | 3.27 seconds  | With the loop removed.
Objective-C  | 1.78 second | Replaced NSLog() with putchar()
Objective-C  | 112  milliseconds| Removed init() and Class variables
C |  115-120 milliseconds |  used printf()
C |  62 milliseconds |  used putchar()
Swift  | 478-600  milliseconds |  Super easy APIs

### Swift
```
for n in 1...100 {
    if n.isMultiple(of: 3) && n.isMultiple(of: 5) { print("fizzBuzz")  }
    else if n.isMultiple(of: 3){ print("fizz") }
    else if n.isMultiple(of: 5){ print("Buzz") }
    else { print(n) }
}
```
### C
Fast out of the box.
![c_fast](/Instrument_FizzBuzz/c_fast.png)

Could still get quicker:
![c_faster](/Instrument_FizzBuzz/c_faster_putchar.png)

```
#include <stdio.h>
#define MAX_N 1000000

void prettyPrint(int rem1, int rem2, int n){
    if (rem1 == 0 && rem2 == 0)
        puts("FizzBuzz");
    else if (rem1 == 0 && rem2 != 0)
        puts("Fizz");
    else if (rem1 != 0 && rem2 == 0)
        puts("Buzz");
    else putchar(n);
}

int main(void) {
    for (int n = 1; n <= MAX_N; n++) {
        prettyPrint(n % 3, n % 5, n);
    }
    return 0;
}
```
### Objective-C (quickest)
```
#import <Foundation/Foundation.h>
#define MAX_N 1000000

@implementation Fizzbar: NSObject

+(void) prettyPrint:(NSInteger)n remainder1:(NSInteger)rem1 remainder2: (NSInteger)rem2 {
    if (rem1 == 0 && rem2 == 0)
        puts("FizzBuzz");
    else if (rem1 == 0 && rem2 != 0)
        puts("Fizz");
    else if (rem1 != 0 && rem2 == 0)
        puts("Buzz");
    else printf("%ld\n", (long)n);
}

@end

int main() {
    @autoreleasepool {
         for (NSInteger n = 1; n <= MAX_N; n++) {
             [Fizzbar prettyPrint:n remainder1:n % 3 remainder2:n % 5];
         }
    }
    return 0;
}
```
### Objective-C
Could still get quicker:
![nslog_slow](/Instrument_FizzBuzz/objc_nslog_slow.png)
```
#import <Foundation/Foundation.h>
#define MAX_N 1000000

@interface FizzBuzz: NSObject {
    NSInteger n;
    unsigned long rem1;
    unsigned long rem2;
}
@end

@implementation FizzBuzz

-(void) prettyPrint{
    if (rem1 == 0 && rem2 == 0)
        puts("FizzBuzz");
    else if (rem1 == 0 && rem2 != 0)
        puts("Fizz");
    else if (rem1 != 0 && rem2 == 0)
        puts("Buzz");
    else putchar(n);
}

-(instancetype) init:(NSInteger)number{
    self = [super init];
    self->n = number;
    self->rem1 = number % 3;
    self->rem2 = number % 5;
    [self prettyPrint];
    return self;
}
@end

int main() {
    @autoreleasepool {
         for (NSInteger n = 1; n <= MAX_N; n++) {
             __unused FizzBuzz *checks = [[FizzBuzz alloc] init:n];
         }
    }
    return 0;
}
```
### Objective-C mistake
My Objective-C first round took between 27 seconds and 34 seconds to complete.

As the size of N grew, the machine cycles increased exponentially due to the below loop:
```
+ (NSString *)getBitStringForInt:(NSInteger)value {
    NSString *bits = @"";
    for(NSInteger i = 0; i < MAX_BITS; i ++) {
        bits = [NSString stringWithFormat:@"%i%@", value & (1 << i) ? 1 : 0, bits];
    }
    return bits;
}
```
