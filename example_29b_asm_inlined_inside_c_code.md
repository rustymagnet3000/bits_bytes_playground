# Assembler - inline assembler inside C source code
### Extended asm
With `extended asm` you can read and write C variables from assembler and perform jumps from assembler code to C labels. Extended asm syntax uses colons (‘:’) to delimit the operand parameters

### Extended asm template
Compiler replaces parameters (%0 above) with real operands (registers, memory references).  Compiler does not try to understand the asm code!
```
asm ( assembler template
	: output operands  /* optional*/
	: input operands   /* optional*/
	: clobber list     /* optional*/
	);
```
### Extended asm example 1
```
int main (void) {
    #if defined(__x86_64__)
        void *stack_ptr;
        asm volatile ("mov %%esp,%0;" : "=g" (stack_ptr));
        printf("Value of ESP register is %p\n", stack_ptr);
    #endif
    return 0;
}
```
### Extended asm example 2
```
int main (void) {
        #elif defined(__x86_64__)
          uint32_t a = 10, b = 0;
          asm ("movl %1, %%eax;"
                "movl %%eax, %0;"
               :"=r"(b)        /* output */
               :"r"(a)         /* input */
               :"%eax"         /* clobbered register */
              );
          printf("Result: %d\n", b);
        #endif
        return 0;
    }
```

##### References
http://labe.felk.cvut.cz/~stepan/33OSD/files/e1-syscalls-inline-asm.pdf
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
