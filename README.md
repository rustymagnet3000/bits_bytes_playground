# Playground for Objective C

### 0. A simple Class
This Objective-C Class was written to show the following:

- An `NSMutableArray`
- If you try and re-use the stock1 Object, it will fail. `NSMutableArray` uses a pointer to an Object
- The underscore syntax for instance variables
- `@property` is a great way to `set/get` instance variables
- The syntax inside the Public API declaration

_Separating ivars from properties_ is from this article https://useyourloaf.com/blog/understanding-your-objective-c-self/

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
Objective-C is all Heap.  Only Blocks are the on the Stack.  By contrast, C++ gave you full control over declaring an Object as from the Heap or the Stack.

### 10. C++ Constructor & Destructor
Compared to Objective-C, I liked the `C++ Constructor` for the busy, forgetful developer.  I struggled at first to understand why the compiler forced you to have a Public Constructor & Destructor.  But it made sense after reading these articles:
```
https://stackoverflow.com/questions/4920277/private-destructor
https://stackoverflow.com/questions/18546035/use-of-public-destructor-when-the-constructor-is-private/18546179#18546179
```
This example code also used `inline` functions to help the compiler.

### 11. C++ Time APIs
I spent a lot of time coding `time` related APIs in C.  In turned out, I forgot Computer Science lesson 1; _re-use_.  I moved to using `difftime` instead of subtracting `Start - End` time.  There was also a bigger C++ lesson in terms of setting a member variable to a `const`.  This was not really possible, when I wanted to create the entire object with `class YDTime mytime;`.  By design I did not want: `class YDTime mytime(local_time);`
```
https://stackoverflow.com/questions/13855890/what-is-the-difference-between-difftime-and
https://stackoverflow.com/questions/14495536/how-to-initialize-const-member-variable-in-a-class
```
### 12. C++ Encapsulation
http://cis1.towson.edu/~cyber4all/modules/nanomodules/Encapsulation-CS2_C++.html
