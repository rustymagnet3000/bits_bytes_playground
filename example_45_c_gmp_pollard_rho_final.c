#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "gmp.h"

#define N "7919261327"
#define MAX_LOOPS 50

/* Assumes 1<a<n, and k=LCM[1,2,3,4...K], some K */
/* RAM remains flat, unlike past examples */
/* Algorithm: https://en.wikipedia.org/wiki/Pollard%27s_rho_algorithm */

int main(void)
{
    mpz_t n, gcd, secretFactor, x, xTemp, xFixed;
        
    int flag, k = 2, loop = 1, count;
    
    mpz_inits( n, gcd, xTemp, secretFactor, NULL );
    mpz_init_set_ui( x, 2 );
    mpz_init_set_ui( xFixed, 2 );
    
    flag = mpz_set_str( n, N, 10 );
    assert(flag == 0);
    
    do {
        count = k;
        gmp_printf("\n----   loop %4i (k = %d, n = %Zd)  ----\n", loop, k, n);
        do {
            
            mpz_mul( x,x,x );
            mpz_add_ui( x,x,1U );
            mpz_mod( x, x, n );
            gmp_printf("%Zd = (x * x + 1) mod n\t\t", x);
            
            mpz_sub( xTemp, x, xFixed );
            mpz_abs ( xTemp, xTemp );
            
            mpz_gcd(  gcd, xTemp, n );
            
            gmp_printf("---- GCD = %Zd ----\n", gcd );
            flag = mpz_cmp_ui (gcd, 1);
            if(flag > 0){
                mpz_cdiv_q (secretFactor, n, gcd);
                gmp_printf("\n\n[*] p:%Zd\t\tq:%Zd\n", gcd, secretFactor);
                break;
            }
        } while (--count && flag == 0);

        k *= 2;
        mpz_set(xFixed,x);
        loop++;
        if(loop >= MAX_LOOPS)
            break;
    } while (flag < 1);

    
    printf("\n[*] Finished k values: %d, loop: %d\n", k, loop);
    
    mpz_clears ( n, gcd, secretFactor, x, xTemp, xFixed, NULL );

    return 0;

}
