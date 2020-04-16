#include <stdio.h>
#include "gmp.h"
#define MAX_K 20

unsigned int naiveFactorial(int k){
    if (k == 0)
        return 1;
    return k * naiveFactorial(k - 1);
}

void gmpFactorial(unsigned int n, mpz_t *f) {
  for (int i=1; i <= n ; ++i){
    mpz_mul_ui(*f,*f,i);
  }
}

int main()
{
    mpz_t fact;
    
    for (int k = 1; k <= MAX_K; k++) {
        mpz_init_set_ui(fact,1);
        gmpFactorial(k, &fact);
        gmp_printf("[*]\t%d Factorial:%Zd\n", k, fact);
    }
    putchar('\n');
    for (int k = 1; k <= MAX_K; k++) {
        unsigned int result = 1;
        result = naiveFactorial(k);
        printf("[*]\t%d Factorial:%d\n", k, result);
    }
    
    mpz_clears ( fact, NULL );
    return 0;
}

[*]	1 Factorial:1
[*]	2 Factorial:2
[*]	3 Factorial:6
[*]	4 Factorial:24
[*]	5 Factorial:120
[*]	6 Factorial:720
[*]	7 Factorial:5040
[*]	8 Factorial:40320
[*]	9 Factorial:362880
[*]	10 Factorial:3628800
[*]	11 Factorial:39916800
[*]	12 Factorial:479001600
[*]	13 Factorial:6227020800
[*]	14 Factorial:87178291200
[*]	15 Factorial:1307674368000
[*]	16 Factorial:20922789888000
[*]	17 Factorial:355687428096000
[*]	18 Factorial:6402373705728000
[*]	19 Factorial:121645100408832000
[*]	20 Factorial:2432902008176640000

[*]	1 Factorial:1
[*]	2 Factorial:2
[*]	3 Factorial:6
[*]	4 Factorial:24
[*]	5 Factorial:120
[*]	6 Factorial:720
[*]	7 Factorial:5040
[*]	8 Factorial:40320
[*]	9 Factorial:362880
[*]	10 Factorial:3628800
[*]	11 Factorial:39916800
[*]	12 Factorial:479001600
[*]	13 Factorial:1932053504
[*]	14 Factorial:1278945280
[*]	15 Factorial:2004310016
[*]	16 Factorial:2004189184
[*]	17 Factorial:-288522240
[*]	18 Factorial:-898433024
[*]	19 Factorial:109641728
[*]	20 Factorial:-2102132736

