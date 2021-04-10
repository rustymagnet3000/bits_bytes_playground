int main() {
    @autoreleasepool {

        NSString *str1 = @"foobar";
        NSString *str2 = [NSString stringWithFormat:@"barbar%d", 55];
        NSString *str3 = [NSString stringWithUTF8String:"foobarfoobar"];

        if ([str1 isKindOfClass:[NSString class]])
        {
            NSLog(@"[+]Mystring isKindOfClass of NSString");
        }

        if (![str1 isMemberOfClass:[NSString class]])
        {
            NSLog(@"\t NOT a MemberOfClass of NSString as it was a subclass");
        }

        NSLog(@"[+]str1: %@\n", str1);
        NSLog(@"\tsuperclass: %@", [str1 superclass]);
        NSLog(@"\tinstance type: %@", [str1 class]);

        NSLog(@"[+]str2: %@\n", str2);
        NSLog(@"\tsuperclass: %@", [str2 superclass]);
        NSLog(@"\tinstance type: %@", [str2 class]);

        NSLog(@"[+]str3: %@\n", str3);
        NSLog(@"\tsuperclass: %@", [str3 superclass]);
        NSLog(@"\tinstance type: %@", [str3 class]);

        if ([str1 isEqualToString:@"foobar"])
        {
            NSLog(@"[+]str1 isEqualToString");
        }

        if ([str2 isEqualToString:@"barbar55"])
        {
            NSLog(@"[+]str2 isEqualToString");
        }

        if ([str3 isEqualToString:@"foobarfoobar"])
        {
            NSLog(@"[+]str3 isEqualToString");
        }

        while(1) {
            sleep(1);
        }
    }
    return 0;
}
