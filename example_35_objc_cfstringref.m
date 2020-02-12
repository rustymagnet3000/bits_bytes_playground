#ifdef __OBJC__
    #import <CoreFoundation/CoreFoundation.h>
#endif

/*
 CFSTR - Creates an immutable string from a constant compile-time string.
 */

int main(void) {
    @autoreleasepool {
        
        CFStringRef str = CFSTR("Hello world");
        CFArrayRef array = CFArrayCreate(NULL, (const void**)&str, 1, &kCFTypeArrayCallBacks);
        CFShow(str);
        CFShowStr(str);
    }
}

/*
 // CFShow
 Hello world

 // CFShowStr
 Length 11
 IsEightBit 1
 HasLengthByte 0
 HasNullByte 1
 InlineContents 0
 Allocator SystemDefault
 Mutable 0
 Contents 0x100000f94
 
 (lldb) po (char *) 0x100000f94
 "Hello world"
 
 */

