#include <stdio.h>
#include "gmp.h"

int main()
{
    mpz_t x, y, result_gcd;
    mpz_inits ( x, y, result_gcd, NULL);
    
    mpz_set_ui(x, 12U);
    mpz_set_ui(y, 18U);
    
    /* GMP's printf  */
    gmp_printf("[*]\tx:%Zd\ty:%Zd\n", x,y);
    mpz_gcd(result_gcd, x, y);
    gmp_printf("[*]\tgcd:%Zd\n", result_gcd);

    mpz_clears ( x, y, result_gcd, NULL );
    return 0;
}

[*]	x:12	y:18
[*]	gcd:6
