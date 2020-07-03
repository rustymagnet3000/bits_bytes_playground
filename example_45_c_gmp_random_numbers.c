#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include "gmp.h"

#define N "10403"
#define MAXLOOPS 300

int main (int argc, char *argv[])
{

    int flag = 0;
    mpz_t n, x, y;
    mpz_inits( n, x, y, NULL );

    flag = mpz_set_str( n, N, 10 );
    assert(flag == 0);

    gmp_randstate_t state;
    gmp_randinit_default(state);
    
    for(int i = 0; i < MAXLOOPS; i++){
        /* seed required for randomness */
        /* using time(NULL) API doesn't work when you are looping like this, as the loop finishes before the time increments  */
        gmp_randseed_ui(state, arc4random());
        
        /* n - 1 is max value of random number */
        mpz_urandomm(x, state, n);
        mpz_urandomm(y, state, n);
        gmp_printf("x:%Zd\ty:%Zd\n", x, y);
    }

    mpz_clears( n, x, y, NULL );
    gmp_randclear ( state );
    
    return 0;
}

