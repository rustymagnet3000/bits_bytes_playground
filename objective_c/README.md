# Bits and bytes

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
    - [objc_20_associated_object_add_variable_at_run_time.m](#objc_20_associated_object_add_variable_at_run_timem)
    - [objc_21_class_instrospection_objc_msgSendTyped](#objc_21_class_instrospection_objc_msgsendtyped)
    - [objc_22_common_crypto_cc_sha256](#objc_22_common_crypto_cc_sha256)
    - [objc_23_cfnumber](#objc_23_cfnumber)
    - [objc_24_cfstringref](#objc_24_cfstringref)
    - [objc_25_cfarray](#objc_25_cfarray)
    - [objc_26_swizzle_instance_method_only](#objc_26_swizzle_instance_method_only)
    - [objc_27_swizzle_class_method_only](#objc_27_swizzle_class_method_only)
    - [objc_28_swizzling_Instance_and_Class_Methods](#objc_28_swizzling_instance_and_class_methods)
    - [objc_29_swizzling_constructor](#objc_29_swizzling_constructor)
    - [objc_30_swizzle_NSUserDefaults](#objc_30_swizzle_nsuserdefaults)
    - [objc_31_swizzling_nsurl](#objc_31_swizzling_nsurl)
    - [objc_32_charactersets](#objc_32_charactersets)
    - [objc_33_nserror](#objc_33_nserror)
    - [objc_34_nserror_pass_by_reference](#objc_34_nserror_pass_by_reference)
    - [objc_35_nsoperation](#objc_35_nsoperation)
    - [objc_36_nsoperation_subclass](#objc_36_nsoperation_subclass)
    - [objc_37_nsthread_create_five_background_threads](#objc_37_nsthread_create_five_background_threads)
    - [objc_38_nsthread_with_nslock](#objc_38_nsthread_with_nslock)
    - [objc_39_nsthread_with_synchronized](#objc_39_nsthread_with_synchronized)
    - [objc_40_read_plist](#objc_40_read_plist)

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

### objc_20_associated_object_add_variable_at_run_time.m

Add a variable to a class at runtime. Uses `objc_setAssociatedObject` and `objc_getAssociatedObject`.

### objc_21_class_instrospection_objc_msgSendTyped

Inspect a `Class` at runtime. Uses the famous `objc_msgSend` and `objc_msgSendTyped`

### objc_22_common_crypto_cc_sha256

Uses `<CommonCrypto/CommonDigest.h>` to do a simple `SHA256`.

### objc_23_cfnumber

Shows how to use `cfnumber`.

### objc_24_cfstringref

Uses `CFSTR` to create a string.

### objc_25_cfarray

Creates an array from strings.

### objc_26_swizzle_instance_method_only

Swizzle a `Class instance method` only.

### objc_27_swizzle_class_method_only

Same as previous but for a `Class method` only.

### objc_28_swizzling_Instance_and_Class_Methods

A more complete swizzling example. Apple [said][4522c6ad]:

  [4522c6ad]: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048-CH1-SW1 "Apple"

> The Objective-C language defers as many decisions as it can from compile time and link time to runtime. Whenever possible, it does things dynamically. This means that the language requires not just a compiler, but also a runtime system to execute the compiled code.

Swizzling used native Objective-C APIs to modify the `dispatch table`.  This  modified `code flow` when the app was running [ long after `compile` and `link` time ].  What an amazing feature of Objective-C.

### objc_29_swizzling_constructor

Invokes the swizzle at app start-up due to the `static void __attribute__((constructor)) initialize(void)` call.

### objc_30_swizzle_NSUserDefaults

More practical use of a swizzle.

### objc_31_swizzling_nsurl

Useful way to inspect `NSURL` calls.

### objc_32_charactersets

Tries to guess the `Type` of decrypted data based on the `NSCharacterSet`.

### objc_33_nserror

How to use `NSError` with ObjC.

### objc_34_nserror_pass_by_reference

Based on Apple's example of Pass By Reference NSError [example](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/ErrorHandling/ErrorHandling.html).

### objc_35_nsoperation

Creates a class that inherits from `NSOperation`.

### objc_36_nsoperation_subclass

Use `NSOperationQueue` and  `queue addOperationWithBlock`.

### objc_37_nsthread_create_five_background_threads

Creates 5 x `Named Threads`.

### objc_38_nsthread_with_nslock

Uses `NSLock` to stop issues with a `mutable array`.

### objc_39_nsthread_with_synchronized

A cleaner way to `lock` the array using `synchronized`.

### objc_40_read_plist

Read a `plist` file.
