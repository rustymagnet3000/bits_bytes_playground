### STACK VERSUS HEAP
```
#include <iostream>
using namespace std;

class Box {
public:
    double length;   // Length of a boxsec
    double breadth;  // Breadth of a box

    void pretty_print() {
        cout << "Address : " << this <<endl;
        cout << "Length : " << length * breadth <<endl;
    }
};

int main() {

    Box *box_heap = new Box();
    Box box_stck;

    box_heap->length = 6.0;
    box_heap->breadth = 7.0;

    box_stck.length = 12.0;
    box_stck.breadth = 13.0;

    box_heap->pretty_print();
    box_stck.pretty_print();

    delete(box_heap);  // box_stck would die automatically on function leave
    return 0;
}
```
### OUTPUT
```
Address : 0x100420860
Length : 42
Address : 0x7ffeefbff580
Length : 15
```
### Debugger print differences
```
(lldb) po box_heap
0x0000000100420860

(lldb) po box_stck

(lldb) p box_heap
(Box *) $3 = 0x0000000100420860
(lldb) p box_stck
(Box) $4 = (length = 3, breadth = 5)

(lldb) frame variable
(Box *) box_heap = 0x0000000100420860
(Box) box_stck = (length = 3, breadth = 5)
```
### Debugger advanced analysis
```
(lldb) command script import lldb.macosx.heap

(lldb) malloc_info --stack-history 0x0000000100420860
0x0000000100420860: malloc(    16) -> 0x100420860
```
