#include <stdio.h>

void prettyPrint(int r, char *operator)
{
    printf("[*]\t%-10s%d:0x%x\n", operator, r, r);
}

int main(void) {

    const int fifteen = 15;
    const int sixteen = 16;
    int result;

    /****************************************************
    128 64  32  16  8   4   2   1           Dec     Hex
     1  1   1   1   1   1   1   1           255     0xff
     0  0   0   0   1   1   1   1           15      0x0f
     0  0   0   1   0   0   0   0           16      0x10

     Bitwise Operators

     & AND
     | OR
     ^ XOR
     ~ Complement
     >> shift right
     << shift left
    *****************************************************/

    result = fifteen & sixteen;
    prettyPrint(result, "AND    ");
    /*
    0  0   0   0   1   1   1   1           15       0x0f
    0  0   0   1   0   0   0   0           16       0x10
    0  0   0   0   0   0   0   0           RESULT   0x00
    */

    result = fifteen | sixteen;
    prettyPrint(result, "OR     ");
    /*
    0  0   0   0   1   1   1   1           15      0x0f
    0  0   0   1   0   0   0   0           16      0x10
    0  0   0   1   1   1   1   1           RESULT  0x31
    */

    result = fifteen ^ sixteen;
    prettyPrint(result, "XOR    ");
    /*
    0  0   0   0   1   1   1   1           15      0x0f
    0  0   0   1   0   0   0   0           16      0x10
    0  0   0   1   1   1   1   1           RESULT  0x31
    */

    result = ~fifteen;
    prettyPrint(result, "COMP   ");
    /*
    0  0   0   0   1   1   1   1           15      0x0f
    1  1   1   1   0   0   0   0           RESULT  ??
    */

    result = fifteen << 2;
    prettyPrint(result, "LEFT 2 ");
    /*
    128 64  32  16  8   4   2   1           Dec     Hex
    0   0   0   0   1   1   1   1           15      0x0f
    0   0   1   1   1   1   0   0           60      0x3c
    */

    result = fifteen << 4;
    prettyPrint(result, "LEFT 4 ");
    /*
     128 64  32  16  8   4   2   1           Dec     Hex
     0  0   0   0   1   1   1   1           15      0x0f
     1  1   1   1   0   0   0   0           240     0xf0
    */

    result = sixteen >> 2;
    prettyPrint(result, "RIGHT 2");
    /*
    128 64  32  16  8   4   2   1           Dec     Hex
    0   0   0   1   0   0   0   0           16      0x10
    0   0   0   0   0   1   0   0           4      0x04
    */

    result = sixteen >> 4;
    prettyPrint(result, "RIGHT 4");
    /*
    128 64  32  16  8   4   2   1           Dec     Hex
    0   0   0   1   0   0   0   0           16      0x10
    0   0   0   0   0   0   0   1           1      0x01
    */
    return 0;
}

/*

    [*]    AND    :            0:0x0
    [*]    OR     :            31:0x1f
    [*]    XOR    :            31:0x1f
    [*]    COMP   :            -16:0xfffffff0
    [*]    LEFT 2 :            60:0x3c
    [*]    LEFT 4 :            240:0xf0
    [*]    RIGHT 2:            4:0x4
    [*]    RIGHT 4:            1:0x1
*/
