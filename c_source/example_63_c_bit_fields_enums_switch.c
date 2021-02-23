@import Foundation;
#include <stdio.h>

typedef enum : NSUInteger {
    CLEAN_DEVICE = 0,
    SUSPECT_JAILBREAK = 1,
    JAILBROKEN,
} JAILBREAKRESULT;

#define CLEAN                   0x00        // 0b00000000
#define JAILBROKEN              0x01        // 0b00000001
#define SANDBOX_ESCAPE          0x02        // 0b00000010
#define CYDIA_PRESENT           0x04        // 0b00000100
#define ELECTRA_PRESENT         0x08        // 0b00001000
#define JB_DYLIB_PRESENT        0x16        // 0b00010000
#define MAX_BITS                5           // max value where Bit Fields are OR'd together 0b00011111 = 5 bits == 0x31


struct {
   unsigned short status : MAX_BITS;
} Jailbreak;

static void prettyPrint()
{
    printf("[*]Jailbreak status:\t\t%d\t\t0x%x\n", Jailbreak.status, Jailbreak.status);
}

const char *getJailbreakStatus() {
    int jb_detection_counter = 0;
    
    for (unsigned short i = 0; i < MAX_BITS; i++) {
        if (Jailbreak.status & (1 << i))
            jb_detection_counter++;
    }
    printf("[*]Jailbreak detections fired: %d\n", jb_detection_counter);
    switch (jb_detection_counter) {
        case CLEAN_DEVICE:
            return "Clean device";
        case SUSPECT_JAILBREAK:
            return "Suspect jailbreak";
        default:
            return "Jailbroken";
    }
}

int main(void) {
    
    printf ( "[*]Sizeof( Jailbreak ) : %lu\n", sizeof (Jailbreak) );
    Jailbreak.status = CLEAN;
    prettyPrint ();
    
    Jailbreak.status = JAILBROKEN;
    prettyPrint ();

    Jailbreak.status = Jailbreak.status | SANDBOX_ESCAPE;
    prettyPrint ();

    Jailbreak.status = JAILBROKEN | SANDBOX_ESCAPE | CYDIA_PRESENT | ELECTRA_PRESENT | JB_DYLIB_PRESENT;
    prettyPrint ();

    Jailbreak.status = CYDIA_PRESENT | ELECTRA_PRESENT;
    prettyPrint ();
    
    printf("[*]Jailbreak status: %s\n", getJailbreakStatus ());
    return 0;
}

