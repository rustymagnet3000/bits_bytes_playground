#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif


#define ARGS_EXPECTED_IN_FILE 3

/* read in a plist file, at Present Working Directory (PWD).
 
    As I mostly build from XCode, I have /Build Phases/Copy Files set to copy the .plist file from my Desktop to the /DerivedData folder where XCode places my built Command Line app.

*/

@interface YDPListReader : NSObject{
    NSString *_name;
    NSString *_file;
    NSDictionary *_foundDictItems;
}

- (instancetype)initWithPlistName:(NSString *)name;

@end

@implementation YDPListReader

- (instancetype)init {
    self = [self initWithPlistName:@"pubKeyAndCipherText"];
    return self;
}

- (BOOL)fileChecks {
    NSString *dir = [[NSProcessInfo processInfo] environment][@"PWD"];
    NSBundle *bundle = [NSBundle bundleWithPath:dir];
    _file = [bundle pathForResource:_name ofType:@"plist"];
    
    if (bundle == NULL || _file == NULL) {
        return NO;
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:_file]){
        return YES;
    }
    return NO;
}

- (BOOL)checkPlistContents {

    _foundDictItems = [NSDictionary dictionaryWithContentsOfFile:_file];
    if (_foundDictItems == NULL || [_foundDictItems count] != ARGS_EXPECTED_IN_FILE){
        NSLog(@"Not able to read plist file or unexpected values");
        return NO;
    }
    
    NSEnumerator *enumerator = [_foundDictItems keyEnumerator];
    
    id key;
    while ((key = [enumerator nextObject])) {
        NSLog(@"%@ %@", key, [_foundDictItems valueForKey:key]);
    }
    
    return YES;
}

- (instancetype)initWithPlistName:(NSString *)name {
    self = [super init];

    if (self) {
        _name = name;
        
        if(![self fileChecks]){
            return NULL;
        }
        NSLog(@"🍭 Found Public Key file");
        if(![self checkPlistContents]){
            return NULL;
        }
        NSLog(@"🍭 Public Key and Ciphertext found");
    }
    return self;
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        YDPListReader *reader = [[YDPListReader alloc] init];
        if(reader == NULL)
            NSLog(@"🍭Can't find Plist file");
    }
    return 0;
}

