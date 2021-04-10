#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *oldStrings = [NSArray arrayWithObjects:
                               @"odd", @"raygun", @"whoop whoop", @"doctor pants", nil];
        NSLog(@"old strings: %@", oldStrings);
        
        NSMutableArray *newStrings = [NSMutableArray array];
        
        NSArray *vowels = [NSArray arrayWithObjects:@"a",@"o",@"e",@"u", nil];
        
        typedef void (^RemoveVowelsBlock)(id, NSUInteger, BOOL *);

        RemoveVowelsBlock remover = ^ (id string, NSUInteger i, BOOL *stop){
            
            NSMutableString *newStr = [NSMutableString stringWithString:string];
            
            for (NSString *s in vowels) {
                NSRange fullRange = NSMakeRange(0, [newStr length]);
                [newStr replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
            }
            
            [newStrings addObject:newStr];
            
        }; // end of block
        
        [oldStrings enumerateObjectsUsingBlock:remover];
        NSLog(@"new strings: %@", newStrings);
    }
    return 0;
}
