// https://www.raywenderlich.com/2484-introduction-to-c-for-ios-developers-part-1

namespace YDNameSpace {
    class MyClass {
    public:
        int x;
        int y;
        void foo() {
            // Do something
        }

    private:
        float z;
        void bar();
    };
}


int main(int argc, const char * argv[]) {
    YDNameSpace::MyClass m;
    m.x = 10;
    m.y = 20;
    m.foo();
    return 0;
}
