#include <assert.h>
#include <stdio.h>

/* bit fields */
#define CLEAN                   0x00        // 0b00000000
#define JAILBROKEN              0x01        // 0b00000001
#define SANDBOX_ESCAPE          0x02        // 0b00000010
#define CYDIA_PRESENT           0x04        // 0b00000100
#define ELECTRA_PRESENT         0x08        // 0b00001000
#define JB_DYLIB_PRESENT        0x16        // 0b00010000
#define MAX_BITS                5           // bit width to max value where Bit Fields are OR'd together 0b00011111 = 5 bits == 0x31
struct {
   unsigned short status : 5;
} JailbreakStatus;

int main( ) {
    
    printf( "Sizeof( JailbreakStatus ) : %lu\n", sizeof (JailbreakStatus) );
    JailbreakStatus.status = CLEAN;
    printf( "JailbreakStatus : %d\n", JailbreakStatus.status );
    
    JailbreakStatus.status = JAILBROKEN;
    printf( "JailbreakStatus : %d\n", JailbreakStatus.status );

    JailbreakStatus.status = JailbreakStatus.status | SANDBOX_ESCAPE;
    printf( "JailbreakStatus : %d\n", JailbreakStatus.status );

    JailbreakStatus.status = JAILBROKEN | SANDBOX_ESCAPE | CYDIA_PRESENT | ELECTRA_PRESENT | JB_DYLIB_PRESENT;
    printf( "JailbreakStatus : %d\n", JailbreakStatus.status );

    /* COMPILER WARNING AS 32 is beyond max width of  -> Implicit truncation from 'int' to bit-field changes value from 32 to 0 */
    JailbreakStatus.status = 32;
    assert((JailbreakStatus.status > 0) && "dont' set value greater than max bit length");
    printf( "JailbreakStatus : %d\n", JailbreakStatus.status );
    return 0;
}


/* 
Sizeof( Jailbreak ) : 2
Jailbreak : 0
Jailbreak : 1
Jailbreak : 3
Jailbreak : 31
Assertion failed: ((Jailbreak.status > 0) && "dont' set value greater than max bit length"), line 33.
*/
