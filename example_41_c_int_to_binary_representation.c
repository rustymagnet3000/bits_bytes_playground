#include <stdio.h>

/*
     Input 10    Binary Number 1010
     How does this work?
     10     60    0
     5      25    1
     2      12    0
     1      1     1
    
    The key bit is (positiveDecimal / 2  * 10).  You think  5 / 2 * 10 = 25?  Wrong. 20.
 
    This code does NOT work on negatives or long inputs. Even 1million is too long.
 
    1 MILLION
    1,000,000
    11110100001001000000_2 (Base2, binary)
    
    2147483647  (my Machine's max, an integer of 2.14 billion)
    11111111111111..._2 (31 digits, binary)
 
    That is enough space, no?  The code  augments 1s and 0s in a single value ( not an array ), blowing up the max size of an int.
 
    11110100001001000000 (20 chars)
    2147483647 (10 chars)
*/

int toBinary(int positiveDecimal);

int main(void) {
    
    printf("Input Max is: %d\n", __INT32_MAX__);
    int input = 100;
    int binaryNum = toBinary(input);
    
    printf("Input %d\t\tBinary Number\t\t%d\n", input, binaryNum);
    
    return 0;
}

int toBinary(int positiveDecimal){
    printf("%d\t%d\t%d\n", positiveDecimal,  (positiveDecimal / 2  * 10 + positiveDecimal), (positiveDecimal / 2  * 10 + positiveDecimal) % 2);
    if (positiveDecimal < 2){
        return positiveDecimal;
    }
    
    return toBinary(positiveDecimal / 2 ) * 10 + positiveDecimal % 2;
}

