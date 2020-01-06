# Bits and bytes
## Mostly ObjC, C++ and C
### 0. A simple Class
This Objective-C Class showed:

- An `NSMutableArray`
- The underscore syntax for instance variables
- `@property` is a great way to `set/get` instance variables

The code was partly inspired by the article _Separating ivars from properties_ [here][82068adb].

  [82068adb]: https://useyourloaf.com/blog/understanding-your-objective-c-self/ "Objective_c_naming"

### 1. Simple synchronous request
Implemented `NSURLSessionDataTask` to send a HTTP request from the command line.
`Semaphores` were used to _wait until_ the task completes.

```
https://www.objc.io/issues/5-ios7/from-nsurlconnection-to-nsurlsession/
https://developer.apple.com/documentation/foundation/nsurlsession/1407613-datataskwithrequest
http://demianturner.com/2016/08/synchronous-nsurlsession-in-obj-c/
https://stackoverflow.com/questions/22206274/handle-http-error-with-nsurlsession
```
### 2. Run Loop and Unused
Created a simple Class to initialize. The instance method was invoked in the `[NSTimer scheduledTimerWithTimeInterval` call.  Bonus: the `timer` response was set to `__unused` to suppress the compiler warning.

### 3. NSNotificationCenter
When the user went into System Preferences and changed the `Timezone` the running Objective-C program outputted a message.   The instance method was invoked on `[NSNotificationCenter defaultCenter] addObserver:logger`.  Finally it was told to act when `name:NSSystemTimeZoneDidChangeNotification`.

### 4. Override Super Init and Property magic
I love the `@property` statement. You magically get a setter: `[machine setTemp: 999]`     and the _dot notation_ of a getter `machine.Temp`.  If your Objective-C class has no `init` statement - the `NSObject` initialiser takes over.  It zeros out Ints and floats and sets Strings to nil.  You can override this function, an example is included here.  Notice the `[self setVoltage: 180]` instead of `voltage = 180`.

### 5. Designated Initialiser
This code example shows `inheritance` and more specifically the `designated initialiser`.  That is the most important initialiser that each Object uses.  There are lots of cases where people can initialise an object incorrectly that must be addressed with code.

### 6. Blocks
In my own mind `blocks` are close cousins of `closure` and `function pointers`.  With Objective-C `Blocks` you can pass around code as you would pass around data.  The syntax is horrible to use.  But you can use a `typedef` to make the declaration of a `Block` simpler.

### 7. Use a debugger to invoke Blocks
Examples of writing Objective-C `Blocks` and calling them with `lldb`.  

### 8. C++ Namespace
A nice feature of C++ compared to Objective-C. You could set a C++ Namespace to ensure your class declaration never conflicted with any definitions that may have the same class name.

### 9. C++ Stack vs Heap
Objective-C is all `Heap`.  Only Blocks are on the `Stack`.  By contrast, C++ gave you full control over declaring an Object on the `Heap` or the `Stack`.

### 10. C++ Constructor & Destructor
Compared to Objective-C, I liked the `C++ Constructor` for the busy, forgetful developer.  I struggled at first to understand why the compiler forced you to have a Public Constructor & Destructor.  But it made sense after reading these articles:
```
https://stackoverflow.com/questions/4920277/private-destructor
https://stackoverflow.com/questions/18546035/use-of-public-destructor-when-the-constructor-is-private/18546179#18546179
```
This example code also used `inline` functions to help the compiler.

### 11. C++ Time APIs
I spent a lot of time coding `time` related APIs in C.  In turned out, I forgot Computer Science lesson 1; _re-use_.  I moved to using `difftime` instead of subtracting `Start - End` time.  I used `ctime` instead of creating my own `char buffer` to print a beautiful time and date.  There was also a C++ lesson in terms of setting a member variable to a `const`.  This was not really possible, when I wanted to create the entire object with `class YDTime mytime;`.  By design I did not want: `class YDTime mytime(local_time);`
```
https://stackoverflow.com/questions/13855890/what-is-the-difference-between-difftime-and
https://stackoverflow.com/questions/14495536/how-to-initialize-const-member-variable-in-a-class
```
### 12. C++ Encapsulation
`Encapsulation` was a major building block of OOP.  It was commonly used to stop _undefined_ behaviour if your Classes were consumed by other developers.  The developer did not have direct line of sight to `private member variables` or `private member functions`. You forced developers to use _getters_ to access values and _setters_.  The latter allowed you to sanitise inputted data.  I loved `Encapsulation` to force compile time errors, when people tried to access `private` values they should not access.  But at run-time, you had access to all `private` data.  With a well-placed `breakpoint` and debugger, you had the `pointer` to the `Class` object and could bypass all of the `getters` and `setters`.  There was a healthy debate about this topic here:
```
https://stackoverflow.com/questions/424104/can-i-access-private-members-from-outside-the-class-without-using-friends
```
### 13. ObjC NSString and isKindOfClass
I wrote this code after answering a question on https://github.com/frida/frida/issues/607.  I tried playing with `NSString` and found on macOS that the platform made optimization decisions that would break Frida hooks placed on the Objective-C method names.  When asking for an NSString, the compiler never actually gave me a pure `NSString`.  I was always given a subclass by `macOS`.  The `isKindOfClass`, `[str1 superclass]` and `[str1 class]` were really useful to find out the reality.

### 14. Structs
This example covered `Structs` and how C offered the flexibility to init on the `heap` (with `malloc`,  and `calloc`) or `stack`  and simple techniques to initialise a `struct`.  This included using a `char buffer` with `memcpy` and `memset`.

### 15. Swizzling
Apple [said][4522c6ad]:

  [4522c6ad]: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048-CH1-SW1 "Apple"

> The Objective-C language defers as many decisions as it can from compile time and link time to runtime. Whenever possible, it does things dynamically. This means that the language requires not just a compiler, but also a runtime system to execute the compiled code.

Swizzling used native Objective-C APIs to modify the `dispatch table`.  This  modified `code flow` when the app was running [ long after `compile` and `link` time ].  What an amazing feature of Objective-C.

When Swizzling, I had to reset my brain for the following code:
```
- (BOOL)fakeNameCheck
{
    BOOL result = [self fakeNameCheck];
    NSLog(@"[+] 🍭 swizzled. Orignal retval: %@", result ? @"YES" : @"NO");
    return TRUE;
}
```
It looked like a `recursive loop` that would cause a crash.  Actually, `[self fakeNameCheck];` now pointed to the original "clean" function.  This was done when you used the Objc API `method_exchangeImplementations(original, replacement);`.

```
References:
// https://pilky.me/dynamic-tips-tricks-with-objective-c/
// https://mikeash.com/tmp/Runtime%20API%20Tour.pdf
```
### 16. Class introspection
The example code expanded on Objective-C's runtime. It showed how to call a `@selector` via `objc_msgSend`.  It also showed the `Class` and `Method` types and the `class_getSuperclass`, `class_getInstanceMethod` and `respondsToSelector` functions.

### 17. Threading in C with PThreads
I enjoyed writing this code; I started two background threads.  Both printed a message to logs.  The goal was to use a debugger to `suspend thread`. But I ended up also trying to `kill thread`.

### 18. Threading in ObjC with NSOperationQueue
ObjC had so many APIs available for `multi-threaded` apps.  I started with `NSOperationQueue`.

### 19. Threading in ObjC with GCD, NSLock and Semaphores
I used `Semaphores` to make sure code waited for background threads to complete. I called a `Block` on each thread with a custom `Object`. I hit an error which related to `NSMutableArray` not being `thread-safe`.
```
malloc: Double free of object
malloc: *** set a breakpoint in malloc_error_break to debug
```
I used an `NSLock` to stop it crashing:
```
  [arrayLock lock]; // NSMutableArray isn't thread-safe
  [fishyArray addObject:[fishObj name]];
  [arrayLock unlock];
```

### 20. C Fork
The most basic example for C's Fork API.

### 21. C++ Linked List
I really enjoyed writing this C++ code.  If you have ever written code and found yourself saying "I don't know how big to make my array?" `Linked-Lists` may be a more suitable `Data Structure`.  Insert quickly with no specific order.  Especially relevant if the data you are reading into the List is already ordered.  The fun piece is the danger; you have to spend time on the `Orders of Operations` when writing your `Linked List`.  It is simple to create unexpected behaviour when your own thoughts are not clear.  Note - I moved all my Nodes to `Heap` objects to ensure the Delete step was nice and tidy.

### 22. C++ Doubly-Linked List
I wanted to show the advantage of a Doubly-Linked list, in terms of deleting a Node.

### 23.Objective-C's Run-time
Add Class, iVar and Method all at runtime. Magic.

### 24.Objective-C NSDictionary
I found an app using an NSDictionary to store sensitive information.  I this piece of code is from Apple and shows how the compiler will breakdown higher level code into more primitive Objective-C types `id` and it will always go back to `NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects`.

### 25.C Byte Array to Objective-C
Piece of code to help understand how I could manipulate code with Frida's Objective-C interface.

### 26.C Bitwise Operators
Simple examples of the C bitwise operators.

### 27.C a vulnerable strcpy
On macOS the linker defaults to swap out a vulnerable `strcpy` with a safe version.  This code is designed to be unsafe to demo the issues with `buffer overflows` and `strcpy`.

### 28.Invoke shell from code
The simplest example of using the C's `execve` to transform the calling process into a new process.  In this case, I spawned a bash shell from the C code.

### 29.ASM compile for ARM64 or ARM32
This write-up shows how to compile source code or ASM code on a 64-bit ARM machine for either 64 or 32 bit targets.  I had to install a `cross-compiler`.
