#### Properties - save some code
To avoid specifying setter and getter functions, you can use @property in the Interface file and @synthesize in the implementation file.
```
#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString *_firstName;
}
    @property (nonatomic, strong)NSString *firstName;
@end

@implementation User
    @synthesize firstName = _firstName;
@end

int main () {

    User *user = [[User alloc] init];
    user.firstName = @"Hook";
    NSLog(@"the captain is: %@", user.firstName);
    return 0;
}
```

#### Static Properties
```
@interface User : NSObject
    @property (class, nonatomic, assign, readonly) NSInteger userCount;
    @property (class, nonatomic, copy) NSUUID *identifier;
    + (void)resetIdentifier;
@end

@implementation User
    static NSUUID *_identifier = nil;
    static NSInteger _userCount = 0;

    + (NSInteger)userCount {
        return _userCount;
    }

    + (NSUUID *)identifier {
        if (_identifier == nil) {
            _identifier = [[NSUUID alloc] init];
        }
        return _identifier;
    }

    + (void)setIdentifier:(NSUUID *)newIdentifier {
        if (newIdentifier != _identifier) {
            _identifier = [newIdentifier copy];
        }
    }

    - (instancetype)init
    {
        self = [super init];
        if (self) {
            _userCount += 1;
        }
        return self;
    }

    + (void)resetIdentifier {
        _identifier = [[NSUUID alloc] init];
    }
@end

int main () {

    User *user;
    for (int i = 0; i < 3; i++) {
        user = [[User alloc] init];
        NSLog(@"User count: %ld",(long)User.userCount);
        NSLog(@"Identifier = %@",User.identifier);
    }

    [User resetIdentifier];
    NSLog(@"Identifier = %@",User.identifier);
    return 0;
}
