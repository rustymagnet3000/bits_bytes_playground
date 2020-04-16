#include <stdio.h>
#include "gmp.h"
#include <assert.h>

#define N 2993
#define MAX_K 10

/*
 Find the Factors of 1403 and 2993 with Pollard Rho's method
 https://www.youtube.com/watch?v=fFJMoIj71nQ
*/

void gmpFactorial(unsigned int n, mpz_t *f) {
  for (int i=1; i <= n ; ++i){
    mpz_mul_ui(*f,*f,i);
  }
}

int main(void)
{
    mpz_t fact, base, res, mod, gcd, secretFactor;

    mpz_inits(res, gcd, secretFactor, NULL);
    mpz_init_set_ui(base,2);
    mpz_init_set_ui(mod,N);

    int flag;
    
    for (int k = 2; k <= MAX_K; k++) {

        /* reset value of Factorial result  */
        mpz_init_set_ui(fact,1);

        /* calculate Factorial of k  */
        gmpFactorial(k, &fact);
        
        /* raise 2 to the power of Exponent, then Mod with the target n (1403)  */
        mpz_powm(res, base, fact, mod);

        /* assert that the API worked  */
        flag = mpz_sgn(fact);
        assert(flag > 0);
        
        /* print results  */
        gmp_printf("[*] Base:%Zd%\tk:%d\tExponent:%Zd\n[*] Result:%Zd\t(base^factorial mod n)\n", base, k, fact, res);

        /* subtract 1 from the result */
        mpz_sub_ui(res,res,1);

        /* get the gcd, with whatever method gmp calculates is most efficient */
        mpz_gcd(gcd, res, mod);
        
        /* print results  */
        gmp_printf("[*]\tgcd:%Zd \t\t( %Zd mod %Zd )\n", gcd, res, mod);
        
        /* if gcd greater than 1, you divide to find second factor  */
        flag = mpz_cmp_ui (gcd, 1);
        if(flag > 0){
            mpz_cdiv_q (secretFactor, mod, gcd);
            gmp_printf("[*]\tp:%Zd\t\tq:%Zd\n", gcd, secretFactor);
            break;
        }
    
        putchar('\n');
    }

    /* free all gmp structs  */
    mpz_clears ( fact, base, res, mod, gcd, secretFactor, NULL );
    return 0;
}


[*] Base:2	k:2	Exponent:2
[*] Result:4	(base^factorial mod n)
[*]	gcd:1 		( 3 mod 2993 )

[*] Base:2	k:3	Exponent:6
[*] Result:64	(base^factorial mod n)
[*]	gcd:1 		( 63 mod 2993 )

[*] Base:2	k:4	Exponent:24
[*] Result:1451	(base^factorial mod n)
[*]	gcd:1 		( 1450 mod 2993 )

[*] Base:2	k:5	Exponent:120
[*] Result:1395	(base^factorial mod n)
[*]	gcd:41 		( 1394 mod 2993 )
[*]	p:41		q:73
Program ended with exit code: 0
