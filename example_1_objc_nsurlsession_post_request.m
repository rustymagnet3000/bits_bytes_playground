#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
            [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
            [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
        ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

int main(void) {
    @autoreleasepool {

        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSURL *url = [NSURL URLWithString:@"https://httpbin.org/post"];
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *each in cookieStorage.cookies) {
            NSLog(@"🍭 Deleting: %@", [each name]);
            [cookieStorage deleteCookie:each];
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";

        // Headers
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"54.0" forHTTPHeaderField:@"App-Version"];
        [request addValue:@"Mozilla/5.0 (Linux; Android 6.0.1; Wileyfox Swift Build/MOB31E; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/51.0.2704.106 Mobile Safari/537.36" forHTTPHeaderField:@"User-Agent"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

        // Form URL-Encoded Body
        NSDictionary* bodyParameters = @{
             @"ingrediant1": @"butter",
             @"ingrediant2": @"chocolate",
             @"ingrediant2": @"sugar",
        };
        request.HTTPBody = [NSStringFromQueryParameters(bodyParameters) dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.waitsForConnectivity = YES;
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSLog(@"🍭 start");
        NSURLSessionDataTask *task = [session dataTaskWithRequest: request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
                                        NSLog(@"🍭 HTTP Response Code: %ld", [res statusCode]);
                                        
                                        NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                        NSLog(@"🍭Response Body: %@", responseBody);
                                        
                                    }
                                    dispatch_semaphore_signal(semaphore);
                            }];
        [task resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"🍭 finish");

    }
    return 0;
}


