#import <Foundation/Foundation.h>


int main(void) {
    @autoreleasepool {

        NSError *error = NULL;
        NSString *str = [[NSString alloc] initWithContentsOfFile:@"~/missing.txt" encoding:NSASCIIStringEncoding error:&error];
        if(!str){
            NSLog(@"Read failed %@", [error localizedDescription]);
        } else {
            NSLog(@"Read from file: %@", str);
        }
        
    }
    return 0;
}

// Read failed The file “missing.txt” couldn’t be opened because there is no such file.
