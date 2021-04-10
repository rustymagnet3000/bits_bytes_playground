```
#include <iostream>
#include <cstdlib>

const int STACK_SIZE = 100;
using namespace std;

class Stack {
    private:
        int count;
        int data[STACK_SIZE];
    public:
        Stack(void);
        ~Stack(void);
        void push(const int item);
        int pop(void);
};

inline Stack::Stack(void)  // constructor
{
    cout << "[+] constructor called " << '\n';
    count = 0;
}

inline Stack::~Stack(void)  // destructor
{
    cout << "[+] destructor called " << '\n';
}

inline void Stack::push(const int item)
{
    data[count] = item;
    ++count;
}

inline int Stack::pop(void)
{
    --count;
    return (data[count]);
}

int main() {

    class Stack stack;      // removed stack.init(). Used the Constructor.

    stack.push(1);
    stack.push(2);
    stack.push(4);
    cout << "4 is expected -> " << stack.pop() << '\n';
    cout << "2 is expected -> " << stack.pop() << '\n';
    cout << "1 is expected -> " << stack.pop() << '\n';

    return 0;
}
```
