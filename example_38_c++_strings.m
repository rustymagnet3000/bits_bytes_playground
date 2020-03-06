#include <iostream>
#define STR_MAX 20

using namespace std;

int main (void) {
    std::string str0("abc");
    str0 = "C+_ String 0";
    str0.at(2) = '+';

    char str1[11] = {'C',' ','s', 't', 'r', 'i', 'n', 'g', ' ', '1','\0'};
    char str2[] = "C string 2";
    
    string str3 = "C++ String 3";

    cout << str0 << "\tsize = " << str0.size() << "\tcapacity = " << str0.capacity() << '\n';
    cout << str1 << endl;
    cout << str2 << endl;
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
