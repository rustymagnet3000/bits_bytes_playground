#include "gmp.h"

#define N "10403" // (101 * 103)

/*
 int main (int argc, char *argv[])
 {
     int number = 10403;
     int x = 2;
     int i = 0;
     
     do {
         printf("x mod n = %i\t\t\t%i\n", x, x * x + 1);
         x = (x * x + 1) % number;
         i++;
     } while (i < 15);
     

     return 0;
 }
 
 x = (x * x + 1) % number;
 
MUST output:

 x = 2
 x = 5
 x = 26
 x = 677
 x = 598
 x = 3903
 x = 3418
 x = 156
 x = 3531
 x = 5168
 x = 3724
 x = 978
 x = 9812
 x = 5983
 x = 9970
 
 */

int main(void)
{
    mpz_t exp, n, x, x_x;
    int flag, i = 0;
    
    mpz_inits(n, x_x, NULL);
    mpz_init_set_ui(x, 2);

    flag = mpz_set_str(n, N, 10);
    assert (flag == 0);
    
    do {
        gmp_printf("X = %Zd\t", x);
        mpz_mul(x_x,x,x);
        mpz_add_ui(x_x,x_x,1U);
        gmp_printf("x_x = %Zd\n", x_x);
        mpz_mod( x, x_x, n );
        i++;
    } while (i < 15 );
    
    mpz_clears ( exp, n, x, x_x, NULL );

    return 0;

}
