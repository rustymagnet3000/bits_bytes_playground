##### lldb and Objective-C Blocks
https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html

These examples are from Apple.  Modified to work with lldb.

##### Hello World in Blocks
```
(lldb) exp
Enter expressions, then terminate with an empty line to evaluate:
1 void (^$simpleBlock)(void) = ^{
2 NSLog(@"hello from a block!");
3 };
4

(lldb) po $simpleBlock()
[1136:66563] hello from a block!
```
##### Calling the Block with a Name
```
A more complicated example that gives the Block a name so it can be called like a function.

(lldb) exp
Enter expressions, then terminate with an empty line to evaluate:
1 double (^$multiplyTwoValues)(double, double) =
2 ^(double firstValue, double secondValue) {
3 return firstValue * secondValue;
4 };
5

(lldb) po $multiplyTwoValues(2,4)
8


(lldb) exp double $result
(lldb) p $result
(double) $result = 0
(lldb) exp $result = $multiplyTwoValues(2,4)
(double) $1 = 8
(lldb) po $result
8
```

##### Get the syntax
```
(lldb) expression
Enter expressions, then terminate with an empty line to evaluate:
1 void(^$remover)(id, NSUInteger, BOOL *) = ^(id string, NSUInteger i,BOOL *stop){
2 NSLog(@"ID: %lu String: %@", (unsigned long)i, string);
3 };
4

(lldb) p $remover
(void (^)(id, NSUInteger, BOOL *)) $remover = 0x00000001021a4110

(lldb) exp [oldStrings enumerateObjectsUsingBlock:$remover]

ID: 0 String: odd
ID: 1 String: raygun
ID: 2 String: whoop whoop
3 String: doctor pants
```
