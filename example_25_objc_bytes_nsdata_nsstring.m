char myArray[] = { 0x41, 0x42, 0x43, 0x44 };
size_t myArraySize = sizeof(myArray);
NSData *data = [NSData dataWithBytes:myArray length:myArraySize];
NSString *myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
NSLog(@"Result: %@");
