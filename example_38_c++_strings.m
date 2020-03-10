#include <iostream>
#define STR_MAX 20

using namespace std;

int main (void) {

    std::string str1 = std::string("C++ String 2");
    
    std::string str2("abc");
    str1 = "C+_ String 1";
    str1.at(2) = '+';
    
    string str3 = "C++ String 3";

    cout << str1 << "\tsize = " << str1.size() << "\tcapacity = " << str1.capacity() << '\n';
    cout << str2 << "\tsize = " << str2.size() << "\tcapacity = " << str2.capacity() << '\n';
    cout << str3 << "\t" << str3.length() << endl;

    string str4 = "C++ ";
    str4.operator+=("string 4");
    operator<<(operator<<(cout, str4) , '\n');
    
    char str5Buffer[STR_MAX];
    cout << "Enter string 5: ";
    cin.getline(str5Buffer, STR_MAX);
    cout << "C++ entered string 5: " << str5Buffer << " length:" << strlen(str5Buffer) << endl;
    
    string str6;
    str6 = to_string(300);
    cout << "C++ string 6 from atoi: " << str6 << endl;
    
    int testInt = 1;
    char testChar = (char)testInt;
    // testChar == '\x01'
    testInt = 0;
    testChar = (char)testInt;
    // testChar == '\0'
    return 0;
}
