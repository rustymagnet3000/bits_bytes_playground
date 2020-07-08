#include "gmp.h"

#define MAXLOOPS 10

int main (int argc, char *argv[])
{

    mpz_t i;
    mpz_init( i );

    while ( ( mpz_cmp_ui ( i , MAXLOOPS ) < 0 )){
        mpz_add_ui(i, i, 1);  /*  i++   */
        mpz_out_str(stdout,10,i);
        puts(" Hello!");
    }

    mpz_clear ( i );
    
    return 0;
}

