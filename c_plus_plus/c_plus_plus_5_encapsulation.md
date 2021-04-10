### Sample Code
```
// Code from:  https://www.tutorialspoint.com/cplusplus/cpp_data_encapsulation.htm

#include <iostream>

using namespace std;

class Adder {
public:
    // constructor
    Adder(int i = 0) {
        total = i;
    }

    // interface to outside world
    void addNum(int number) {
        total += number;
    }

    // interface to outside world
    int getTotal() {
        return total;
    };

private:
    // hidden data from outside world
    int total;
};

int main() {
    Adder a;

    a.addNum(10);
    a.addNum(20);
    a.addNum(30);

    cout << "Total " << a.getTotal() <<endl;
    return 0;
}
```
### Debugger ignores Encapsulation
Set a breakpoint on the `cout` line.
```
(lldb) p a
(Adder) $1 = (total = 60)
(lldb) p a.getTotal()
(int) $2 = 60
(lldb) p a.total
(int) $3 = 60
(lldb) exp a.total = a.total + 3
(int) $4 = 63
(lldb) p a.getTotal()
(int) $5 = 63
```
