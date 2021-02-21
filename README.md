# Bits and bytes

Snippets of Objective-C, C, C++, asm, Swift and Python

<!-- TOC depthfrom:2 depthto:4 withlinks:true updateonsave:true orderedlist:false -->

- [Objective-C](#objective-c)
    - [objc_0_simple_class.m](#objc_0_simple_classm)
    - [objc_1_nsurlsession_synchronous_request.m](#objc_1_nsurlsession_synchronous_requestm)
    - [objc_2_nsurlsession_cookies.m](#objc_2_nsurlsession_cookiesm)
    - [objc_3_nsurlsession_post_request.m](#objc_3_nsurlsession_post_requestm)
    - [objc_4_simple_property.m](#objc_4_simple_propertym)
    - [objc_5_init.m](#objc_5_initm)
    - [objc_6_init_and_property.m](#objc_6_init_and_propertym)
    - [objc_7_iskindof.m](#objc_7_iskindofm)
    - [objc_8_respond_to_selector.m](#objc_8_respond_to_selectorm)
    - [objc_9_nsdictionary.m](#objc_9_nsdictionarym)
    - [objc_10_nsdictionary_literal_syntax.m](#objc_10_nsdictionary_literal_syntaxm)
    - [objc_11_block.m](#objc_11_blockm)
    - [objc_11_nsdate.m](#objc_11_nsdatem)
    - [objc_12_nstimeInterval.m](#objc_12_nstimeintervalm)
    - [objc_13_static_class_property.m](#objc_13_static_class_propertym)
    - [objc_14_nsurlsession_with_tiny_delegate.m](#objc_14_nsurlsession_with_tiny_delegatem)
    - [objc_15_progress_bar_and_nsnotification_center_run_loop.m](#objc_15_progress_bar_and_nsnotification_center_run_loopm)
    - [objc_16_uiview_from_code.m](#objc_16_uiview_from_codem)
    - [objc_17_global_dispatch_gcd_pthreads.m](#objc_17_global_dispatch_gcd_pthreadsm)
    - [objc_18_writing_a_category__to_return_bytes_from_nsdata.m](#objc_18_writing_a_category__to_return_bytes_from_nsdatam)
    - [objc_19_runtime_add_ivar_add_method_to_class.m](#objc_19_runtime_add_ivar_add_method_to_classm)
- [C++](#c)
    - [c_plus_plus_1_namespace](#c_plus_plus_1_namespace)
    - [c_plus_plus_2_stack_vs_heap](#c_plus_plus_2_stack_vs_heap)
    - [c_plus_plus_3_constructor](#c_plus_plus_3_constructor)
    - [c_plus_plus_4_time](#c_plus_plus_4_time)
    - [c_plus_plus_5_encapsulation](#c_plus_plus_5_encapsulation)
    - [c_plus_plus_6_strings](#c_plus_plus_6_strings)
    - [c_plus_plus_7_linked_list](#c_plus_plus_7_linked_list)
    - [C++ Doubly-Linked List](#c-doubly-linked-list)
    - [c_plus_plus_8_doubly_linked_list](#c_plus_plus_8_doubly_linked_list)
- [c](#c)
    - [c_3_malloc_memcpy_memset_calloc](#c_3_malloc_memcpy_memset_calloc)
    - [c_5_fork](#c_5_fork)
    - [c_6_bit_fields](#c_6_bit_fields)
    - [c_10_bitwise_operators](#c_10_bitwise_operators)
    - [c_15_threads_with_pthreads](#c_15_threads_with_pthreads)
    - [C Vulnerable strcpy](#c-vulnerable-strcpy)
    - [a.C Invoke shell from code](#ac-invoke-shell-from-code)
    - [b.ASM Shellcode for execve](#basm-shellcode-for-execve)
    - [ASM compile for ARM64 or ARM32](#asm-compile-for-arm64-or-arm32)
    - [C Syscall](#c-syscall)
    - [Writing in-line assembly code in C](#writing-in-line-assembly-code-in-c)
- [GMP](#gmp)
    - [c_gmp_1_basics](#c_gmp_1_basics)
    - [c_gmp_2_checking_for_errors](#c_gmp_2_checking_for_errors)
    - [c_gmp_3_export](#c_gmp_3_export)
    - [c_gmp_4_factorial](#c_gmp_4_factorial)
    - [c_gmp_5_gcd](#c_gmp_5_gcd)
    - [c_gmp_6_import_byte_array_print_hex](#c_gmp_6_import_byte_array_print_hex)
    - [c_gmp_7_loop](#c_gmp_7_loop)
    - [c_gmp_8_pollard_rho_final](#c_gmp_8_pollard_rho_final)
    - [c_gmp_9_pollard_rho_find_factors](#c_gmp_9_pollard_rho_find_factors)
    - [c_gmp_pollard_rho_fix](#c_gmp_pollard_rho_fix)
    - [c_gmp_random_numbers](#c_gmp_random_numbers)
    - [](#)
    - [ObjC NSString and isKindOfClass](#objc-nsstring-and-iskindofclass)
    - [Class introspection](#class-introspection)
    - [Threading in ObjC with NSOperationQueue](#threading-in-objc-with-nsoperationqueue)
    - [Objective-C's Run-time](#objective-cs-run-time)
    - [Objective-C NSDictionary](#objective-c-nsdictionary)
    - [Threading in ObjC with GCD, NSLock and Semaphores](#threading-in-objc-with-gcd-nslock-and-semaphores)
    - [Swizzling](#swizzling)
    - [C Byte Array to Objective-C](#c-byte-array-to-objective-c)
    - [Objective-C Respond to Selector](#objective-c-respond-to-selector)

<!-- /TOC -->

## Objective-C

### objc_0_simple_class.m

This Objective-C Class showed an `NSMutableArray`, the underscore syntax for instance variables. Also, the used `@property` as a great way to `set/get` instance variables.  The code was partly inspired by the article _Separating ivars from properties_ [here][82068adb].

  [82068adb]: https://useyourloaf.com/blog/understanding-your-objective-c-self/ "Objective_c_naming"

### objc_1_nsurlsession_synchronous_request.m

Implemented `NSURLSessionDataTask` to send a HTTP request from the command line.  `Semaphores` were used to _wait until_ the task completes.

### objc_2_nsurlsession_cookies.m

Shows how to parse `cookies` from `[NSHTTPCookieStorage sharedHTTPCookieStorage]` after getting a server response.

### objc_3_nsurlsession_post_request.m

Creates a `POST` request for `NSURLSession`. Uses `enumerateKeysAndObjectsUsingBlock` to add request parameters.

### objc_4_simple_property.m

How to use a `Property` to auto generate `getters` and `setters`.  You magically get a setter: `[machine setTemp: 999]` and the _dot notation_ of a getter `machine.Temp`.  If your Objective-C class has no `init` statement - the `NSObject` initialiser takes over.  It zeros out Ints and floats and sets Strings to nil.

### objc_5_init.m

Use a custom `Init` call to create a `Class`.  This code example shows `inheritance` and a `designated initialiser`.  That is the most important initialiser that each Object uses.

### objc_6_init_and_property.m

Nice way to combine `Init` and `Set` a `Property` at the same time.

### objc_7_iskindof.m

When working with `ObjC` and `Classes` and `subclasses` you see code like `[str1 isKindOfClass:[NSString class]]` and `isMemberOfClass` often. Example also includes `isEqualToString`.  On macOS, the compiler could make optimization decisions.  With a script from `frida.re` I asked for an NSString. The ObjC run-time never gave me a pure `NSString`.  I was always given a subclass by `macOS`.  The `isKindOfClass` helped test the code before I treated as a certain `Class`.

### objc_8_respond_to_selector.m

`[StockHolding respondsToSelector:shareNameMethod]` is very useful when working with `run-time ObjC` code like `swizzling` or `introspection`.

### objc_9_nsdictionary.m

Ways to `initialize` and `enumerate` through `NSDictionary`.  Also illustrates the `valueForKey`API.

### objc_10_nsdictionary_literal_syntax.m

Ways to `initialize NSDictionary` with `C` style literal syntax.

### objc_11_block.m

In my own mind `blocks` are close cousins of `closure` and `function pointers`.  With Objective-C `Blocks` you can pass around code as you would pass around data.  The syntax is ugly and hard to master.  But you can use a `typedef` to make the declaration of a `Block` simpler.

### objc_11_nsdate.m

Use `NSDateFormatter` to create a pretty date.  Subtract `NSDate` values with `timeIntervalSinceDate`.

### objc_12_nstimeInterval.m

A great way to print time information in different formats. Example: `2 days, 13 hours, 43 minutes, 42 seconds`.

### objc_13_static_class_property.m

WWDC 2016/XCode 8 (what's new in LLVM session @5:05) `Static Class` added to ObjC after being introduced in Swift. <https://stackoverflow.com/questions/695980/how-do-i-declare-class-level-properties-in-objective-c>.

### objc_14_nsurlsession_with_tiny_delegate.m

Tiny piece of code to show a `Delegate` piece of code - and the `didReceiveChallenge` method - firing when using `NSURLSession`.  They are glued together with this line of code: `[NSURLSession sessionWithConfiguration:config delegate:del delegateQueue:nil];`.

### objc_15_progress_bar_and_nsnotification_center_run_loop.m

Prints a `progress bar` while `Run Loop` exists.  Uses `NSNotificationCenter` to send a message when loop is finished.  

### objc_16_uiview_from_code.m

Create a `UIView` in five lines of code.

### objc_17_global_dispatch_gcd_pthreads.m

An `ObjC` class that uses `GCD`, `Locks` and `NSTimeInterval`.

### objc_18_writing_a_category__to_return_bytes_from_nsdata.m

Added a `Category` to `NSData` without subclassing `NSData`.  Takes a `byte array`. Initialize an `NSData` object.   Similiar to `Extensions` in Swift.

### objc_19_runtime_add_ivar_add_method_to_class.m

Reference is from <https://gist.github.com/mikeash/7603035>.  where he adds a `method` and `ivar` at run-time.  Sounds simple but `Automatic Reference Counting (ARC)` stopped me for a long time. The code won't compile with ARC on.

## C++

### c_plus_plus_1_namespace

A nice feature of C++ compared to Objective-C. You could set a C++ Namespace to ensure your class declaration never conflicted with any definitions that may have the same class name.

### c_plus_plus_2_stack_vs_heap

Objective-C is all `Heap`.  Only Blocks are on the `Stack`.  By contrast, C++ gave you full control over declaring an Object on the `Heap` or the `Stack`.

### c_plus_plus_3_constructor

Compared to Objective-C, the `C++ Constructor` was helpful for the busy, forgetful developer.  Why did the compiler force you to have a `Public Constructor` and `Destructor`.  Made sense after reading these articles:

- <https://`stackoverflow`.com/questions/4920277/private-destructor>
- <https://stackoverflow.com/questions/18546035/use-of-public-destructor-when-the-constructor-is-private/18546179#18546179>

This example code also used `inline` functions to help the compiler.

### c_plus_plus_4_time

I spent a lot of time coding `time` related APIs in C.  In turned out, I forgot Computer Science lesson 1; _re-use_.  I moved to using `difftime` instead of subtracting `Start - End` time.  I used `ctime` instead of creating my own `char buffer` to print a beautiful time and date.  There was also a C++ lesson in terms of setting a member variable to a `const`.  This was not really possible, when I wanted to create the entire object with `class YDTime mytime;`.  By design I did not want: `class YDTime mytime(local_time);`

- <https://stackoverflow.com/questions/13855890/what-is-the-difference-between-difftime-and>
- <https://stackoverflow.com/questions/14495536/how-to-initialize-const-member-variable-in-a-class>

### c_plus_plus_5_encapsulation

`Encapsulation` was a major building block of OOP.  It was commonly used to stop _undefined_ behaviour if your Classes were consumed by other developers.  The developer did not have direct line of sight to `private member variables` or `private member functions`. You forced developers, who re-used your code, to use _getters_ to access values and _setters_.  The latter allowed you to sanitise inputted data.  

I loved `Encapsulation` to force compile time errors, when people tried to access `private` values they should not access.  But at run-time, you had access to all `private` data.  With a well-placed `breakpoint` and debugger, you had the `pointer` to the `Class` object and could bypass all of the `getters` and `setters`.  There was a healthy debate about this topic here:

- <https://stackoverflow.com/questions/424104/can-i-access-private-members-from-outside-the-class-without-using-friends>

### c_plus_plus_6_strings

> tba

### c_plus_plus_7_linked_list

If you wrote code and found yourself saying "I don't know how big to make my array?" `Linked-Lists` may be a more suitable `Data Structure`.  

You can insert quickly with no specific order into a `Linked-Lists`.

Especially relevant if the data you are reading into the List is already ordered.  The fun piece is the danger; you have to spend time on the `Orders of Operations` when writing your `Linked List`.  It is simple to create unexpected behaviour when your own thoughts are not clear.

### 22. C++ Doubly-Linked List

A `Doubly-Linked list` was efficient at deleting a Node.

### c_plus_plus_8_doubly_linked_list

> tba

## c

### c_3_malloc_memcpy_memset_calloc

This example covered `Structs` and how C offered the flexibility to init on the `heap` (with `malloc`,  and `calloc`) or `stack`  and simple techniques to initialise a `struct`.  This included using a `char buffer` with `memcpy` and `memset`.

### c_5_fork

The most basic example for C's Fork API.

### c_6_bit_fields

> tba

### c_10_bitwise_operators

Simple examples of the C bitwise operators.

### c_15_threads_with_pthreads

I enjoyed writing this code; I started two background threads.  Both printed a message to logs.  The goal was to use a debugger to `suspend thread`. But I ended up also trying to `kill thread`.



### 27.C Vulnerable strcpy
On macOS the linker defaults to swap out a vulnerable `strcpy` with a safe version.  This code is designed to be unsafe to demo the issues with `buffer overflows` and `strcpy`.

### 28a.C Invoke shell from code
The simplest example of C's `execve` to transform the calling process into a new process.  This example showed how to spawn a bash shell from code.

### 28b.ASM Shellcode for execve
Transform the `asm` code into shellcode.  Only for `arm` hosts.

### 29.ASM compile for ARM64 or ARM32
This write-up shows how to compile source code or ASM code on a 64-bit ARM machine for either 64 or 32 bit targets.  I had to install a `cross-compiler`.

### 30.C Syscall
Circumvent `libC` and directly invoke the Operating System with `Syscall` on `macOS` and `linux`.

### 31.Writing in-line assembly code in C
Write ASM instructions inside of C code for Linux ARM.

## GMP

### c_gmp_1_basics

> tba

### c_gmp_2_checking_for_errors

> tba

### c_gmp_3_export

> tba

### c_gmp_4_factorial

> tba

### c_gmp_5_gcd

> tba

### c_gmp_6_import_byte_array_print_hex

> tba

### c_gmp_7_loop

> tba

### c_gmp_8_pollard_rho_final

> tba

### c_gmp_9_pollard_rho_find_factors

> tba

### c_gmp_pollard_rho_fix

> tba

### c_gmp_random_numbers

> tba

### 


### 13. ObjC NSString and isKindOfClass

I wrote this code after answering a question on https://github.com/frida/frida/issues/607.  I tried playing with `NSString` and found on macOS that the platform made optimization decisions that would break Frida hooks placed on the Objective-C method names.  When asking for an NSString, the compiler never actually gave me a pure `NSString`.  I was always given a subclass by `macOS`.  The `isKindOfClass`, `[str1 superclass]` and `[str1 class]` were really useful to find out the reality.

### 16. Class introspection

The example code expanded on Objective-C's runtime. It showed how to call a `@selector` via `objc_msgSend`.  It also showed the `Class` and `Method` types and the `class_getSuperclass`, `class_getInstanceMethod` and `respondsToSelector` functions.


### 18. Threading in ObjC with NSOperationQueue
ObjC had so many APIs available for `multi-threaded` apps.  I started with `NSOperationQueue`.

### 23.Objective-C's Run-time
Add Class, iVar and Method all at runtime. Magic.

### 24.Objective-C NSDictionary
I found an app using an NSDictionary to store sensitive information.  I this piece of code is from Apple and shows how the compiler will breakdown higher level code into more primitive Objective-C types `id` and it will always go back to `NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects`.

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






### 25.C Byte Array to Objective-C
Piece of code to help understand how I could manipulate code with Frida's Objective-C interface.



### 32.Objective-C Respond to Selector
Check whether an Instance Method or Class Method exists, before calling.
