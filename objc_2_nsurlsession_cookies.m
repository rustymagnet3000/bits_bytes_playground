#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

int main(void) {
    @autoreleasepool {

        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSURL *url = [NSURL URLWithString:@"https://httpbin.org/cookies/set/FOOCOOKIE/bar"];
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *each in cookieStorage.cookies) {
            NSLog(@"🍭 Deleting: %@", [each name]);
            [cookieStorage deleteCookie:each];
        }
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSLog(@"🍭 start");
        NSURLSessionDataTask *task = [session dataTaskWithRequest: request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
                                        NSLog(@"🍭 HTTP Response Code: %ld", [res statusCode]);
                                        NSDictionary *dictionary = [res allHeaderFields];
                                        NSLog(@"%@", [dictionary description]);
                                        
                                        for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
                                        {
                                            NSLog(@"name: '%@'",   [cookie name]);
                                            NSLog(@"value: '%@'",  [cookie value]);
                                            NSLog(@"domain: '%@'", [cookie domain]);
                                            NSLog(@"path: '%@'",   [cookie path]);
                                        }
                                    }
                                    dispatch_semaphore_signal(semaphore);
                            }];
        [task resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"🍭 finish");

    }
    return 0;
}


