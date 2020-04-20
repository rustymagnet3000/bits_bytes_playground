#include <stdio.h>
#include <assert.h>
#include "gmp.h"

/* GMP health checks */

int main(void)
{
    mpz_t a, b, c, d;
    int flag = 0;

    mpz_inits ( a, b, c, d, NULL);
    
    const char *raw_a = "1111foo2222";
    const char *raw_b = "100";
    const char *raw_c = "1034776851837418228051242693253376923";
    const char *raw_d = "";
    
    /* check for bad number */
    flag = mpz_set_str(a, raw_a, 10);
    if(flag != 0)
        puts("[*] a: error setting decimal value with gmp");

    /* assert on bad number */
    flag = mpz_set_str(b, raw_b, 10);
    assert(flag == 0);

    /* BAD - ignores the return value */
    mpz_set_str(c, raw_c, 10);
    mpz_set_str(d, raw_d, 10);

    /* check for even number */
    flag = mpz_even_p(b);
    if(flag != 0)
        puts("[*] b: even number");

    /* check length in bits */
    size_t massiveStr;
    massiveStr = mpz_sizeinbase(c, 2);
    printf("[*] c: %zu bits\n", massiveStr);
    
    /* check for empty value */
    flag = mpz_sgn(d);
    if(flag == 0)
        gmp_printf("[*] d: %Zd empty!\n", d);
    
    return 0;
}

