#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

int main()
{
    @autoreleasepool
    {

        NSString *someValue = @"foobar";
        id objects[] = { someValue, @42, @YES };
        id keys[] = { @"myString", @"myNumber", @"myBool" };
        NSUInteger count = sizeof(objects) / sizeof(id);
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects
                                                               forKeys:keys
                                                                 count:count];

        for (NSString *key in dictionary) {
            id value = dictionary[key];
            NSLog(@"Value: %@ \tKey: %@", value, key);
        }

        NSEnumerator *enumerator = [dictionary keyEnumerator];
        id key;
         
        while ((key = [enumerator nextObject])) {
            NSLog(@"%@ class: %@", key, [key class]);
        }

        id val = [dictionary valueForKey:@"myBool"];
        NSLog(@"myBool = %@, class = %@", val, [val class]);
        
        val = [dictionary valueForKey:@"myNumber"];
        NSLog(@"myBool = %@, class = %@", val, [val class]);
    }
    return 0;
}

