#include <iostream>
#define STR_MAX 20

using namespace std;

int main (void) {
    char str1[11] = {'C',' ','s', 't', 'r', 'i', 'n', 'g', ' ', '1','\0'};
    char str2[] = "C string 2";
    string str3 = "C++ String 1";

    cout << str1 << endl;
    cout << str2 << endl;
    cout << str3 << endl;
    cout << str3.length() << endl;
    cout << str3.size() << endl;

    char str4Buffer[STR_MAX];
    std::cout << "Enter string 4: ";
    cin.getline(str4Buffer, STR_MAX);
    cout << str4Buffer << endl;
    cout << strlen(str4Buffer) << endl;
    
    string str5;
    str5 = to_string(300);
    cout << str5 << endl;
    
    int testInt = 1;
    char testChar = (char)testInt;
    // testChar == '\x01'
    testInt = 0;
    testChar = (char)testInt;
    // testChar == '\0'
    return 0;
}



