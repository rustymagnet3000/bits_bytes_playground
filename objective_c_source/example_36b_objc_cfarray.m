#import <CoreFoundation/CoreFoundation.h>

int main(void) {
    @autoreleasepool {
        
        #pragma mark: Create a mutable CFArray
        CFMutableArrayRef arrayOfStrs = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
        
        char buffer[10];
        for (int i=1; i <=5; i++) {
            sprintf(buffer, "String %d", i);
            CFStringRef string = CFStringCreateWithCString(kCFAllocatorDefault, buffer, kCFStringEncodingUTF8);
            CFArrayAppendValue(arrayOfStrs, string);
            CFRelease(string);
        }
        CFShow(arrayOfStrs);
        
        #pragma mark: get values inside of CFArray
        CFIndex count = CFArrayGetCount(arrayOfStrs);
        for (int i=0;i<count;i++) {
            CFStringRef str = CFArrayGetValueAtIndex(arrayOfStrs, i);
            CFShow(str);
            CFRelease(str);
        }
        
        CFRelease(arrayOfStrs);
        
        #pragma mark: create Array from Bundle
        CFBundleRef bundle = CFBundleGetMainBundle();
        CFArrayRef bundleArray = CFBundleCopyExecutableArchitectures(bundle);
        CFIndex bundleCount = CFArrayGetCount( bundleArray );
        for ( int i = 0; i < bundleCount ; ++i  )
        {
            CFStringRef bStr = CFArrayGetValueAtIndex( bundleArray, i );
            CFShow(bStr);
            CFRelease(bStr);
        }
        
        CFRelease( bundleArray );

        #pragma mark: create byte array
        static uint8_t bytes[] = { 0x41, 0x42, 0x43, 0x44 };
        CFStringRef str1 = CFStringCreateWithBytes(NULL, bytes, sizeof(bytes), kCFStringEncodingUTF8, TRUE);
        CFShow(str1);
	CFRelease(str1);
    }
}

/*
 (
     "String 1",
     "String 2",
     "String 3",
     "String 4",
     "String 5"
 )
 String 1
 String 2
 String 3
 String 4
 String 5
 
 <CFNumber 0xdee1fa5c467f0d5f [0x7fff8c17d8e0]>{value = +16777223, type = kCFNumberSInt32Type}
 ABCD
 
 */
