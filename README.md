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
In my own mind `blocks` are close cousins of `closure` and `function pointers`.  With Objective-C `Blocks` you can pass around code as you would pass around data.  The syntax is horrible to use.  But you can use a `typedef` to make the declaration of a `Block` simpler.˜

### 6. Blocks with lldb
Examples of writing Objective-C `Blocks` and calling them with `lldb`.  
