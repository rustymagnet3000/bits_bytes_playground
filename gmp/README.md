# Bits and bytes

<!-- TOC depthfrom:2 depthto:4 withlinks:true updateonsave:true orderedlist:false -->

- [GMP](#gmp)
    - [c_gmp_1_basics](#c_gmp_1_basics)
    - [c_gmp_2_checking_for_errors](#c_gmp_2_checking_for_errors)
    - [c_gmp_3_export](#c_gmp_3_export)
    - [c_gmp_4_factorial](#c_gmp_4_factorial)
    - [c_gmp_5_gcd](#c_gmp_5_gcd)
    - [c_gmp_6_import_byte_array_print_hex](#c_gmp_6_import_byte_array_print_hex)
    - [c_gmp_7_loop](#c_gmp_7_loop)
    - [c_gmp_8_pollard_rho_final](#c_gmp_8_pollard_rho_final)
    - [c_gmp_9_pollard_rho_find_factors](#c_gmp_9_pollard_rho_find_factors)
    - [c_gmp_10_pollard_rho_fix](#c_gmp_10_pollard_rho_fix)
    - [c_gmp_11_random_numbers](#c_gmp_11_random_numbers)

<!-- /TOC -->

## GMP

### c_gmp_1_basics

Initialie an `Integer Type` called `mpz`. Convert a `const char *` to a `GMP` Type.

### c_gmp_2_checking_for_errors

Work with multiple `const char *` Types from `C`.  Check a `GMP` integer for `even`, `size in bits` and `empty value`.

### c_gmp_3_export

Asks the `mpz_export` function to detect the `Type` of a decrypted value.

### c_gmp_4_factorial

Shows why `gmpFactorial` is the only choice when working with large numbers.

### c_gmp_5_gcd

Calls `mpz_gcd` to return the `Greatest Common Demoninator`.

### c_gmp_6_import_byte_array_print_hex

Imports a `Byte Array` into `GMP's` `mpz_t struct`.

### c_gmp_7_loop

A regular `C while loop` used together with `GMP's mpz_cmp_ui`.

### c_gmp_8_pollard_rho_final

A `GMP` implementation of `Pollard's Rho Algorithm`.

### c_gmp_9_pollard_rho_find_factors

A broken implementation of the same.

### c_gmp_10_pollard_rho_fix

TBA.

### c_gmp_11_random_numbers

Calls `gmp_randstate_t` and `gmp_randinit_default`.  Then goes onto call `gmp_randseed_ui`.  Ultimiately it calls `arc4random()` for random input.
