# Bits and bytes

<!-- TOC depthfrom:2 depthto:4 withlinks:true updateonsave:true orderedlist:false -->

- [C++](#c)
    - [c_plus_plus_1_namespace](#c_plus_plus_1_namespace)
    - [c_plus_plus_2_stack_vs_heap](#c_plus_plus_2_stack_vs_heap)
    - [c_plus_plus_3_constructor](#c_plus_plus_3_constructor)
    - [c_plus_plus_4_time](#c_plus_plus_4_time)
    - [c_plus_plus_5_encapsulation](#c_plus_plus_5_encapsulation)
    - [c_plus_plus_6_strings](#c_plus_plus_6_strings)
    - [c_plus_plus_7_linked_list](#c_plus_plus_7_linked_list)
    - [c_plus_plus_8_doubly_linked_list](#c_plus_plus_8_doubly_linked_list)

<!-- /TOC -->

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

### c_plus_plus_8_doubly_linked_list

A `Doubly-Linked list` was efficient at deleting a Node.
