# Assembler - inline assembler inside C source code
### https://en.wikipedia.org/wiki/Inline_assembler
In computer programming, an inline assembler is a feature of some compilers that allows low-level code written in assembly language to be embedded within a program, among code that otherwise has been compiled from a higher-level language such as C or Ada.

### Extended asm
With `extended asm` you can read and write C variables from assembler and perform jumps from assembler code to C labels. Extended asm syntax uses colons (‘:’) to delimit the operand parameters

### Registers
Argument  | Register | x86_64  | arm64
--|---|--|--
Return  | -  | RAX | -
First  | arg1 | RDI | x0
Second  | arg2 | RSI | x1
Third  |  arg3| RDX |  x2
Fourth  | arg4 | RCX  | x3
Fifth  | arg5 | R8  | x4
Sixth  | arg6 |  R9 | x5
Syscalls  | - | syscall  | x16


### Extended asm template
Compiler replaces parameters (%0 above) with real operands (registers, memory references).  Compiler does not try to understand the asm code!
```
/* Extended inline assembly syntax */
__asm [volatile] (code_template
       : output_operand_list
      [: input_operand_list
      [: clobbered_register_list]]
  );
```
### Add two int values ( arm64 )
```
#if defined(__arm64__)
    int i = 3;
    int j = 4;
    int res = 0;
    __asm ("ADD %[result], %[input_i], %[input_j]"
    : [result] "=r" (res)
    : [input_i] "r" (i), [input_j] "r" (j)
    );
    NSLog(@"Result: %d", res);
```

### Copy pointers ( arm64 )
```
void asmfunc(short *pOut, short *pIn) {
    asm volatile(
            "ldr x3, %[in]\n"
            "lsr x3, x3, #1\n"
            "str x3, %[out]\n"
            :[out] "=m" (*pOut)
            :[in] "m" (*pIn)
            :"r3", "memory"
    );
}
```
### Call Access() to check file exists
```
+(int64_t) asmSyscallFunction:(const char *) fp{
   int64_t res = 99;
   __asm (
          "mov x0, #33\n" // access
          "mov x1, %[input_path]\n" // copy char* to x1
          "mov x2, #0\n"
          "mov x16, #0\n"
          "svc #33\n"
          "mov %[result], x0 \n"
   : [result] "=r" (res)
   : [input_path] "r" (fp)
   : "x0", "x1", "x2", "x16", "memory"
   );
   return res;
}

+(BOOL)checkFileExists{

   BOOL file_exists = NO;
   NSBundle *appbundle = [NSBundle mainBundle];
   NSString *filepath = [appbundle pathForResource:@"Info" ofType:@"plist"];
   const char *fp = filepath.fileSystemRepresentation;

   #if defined(__arm64__)
       NSLog(@"access for __arm64__ with ASM instructions");
       int64_t result = [self asmSyscallFunction:fp];
       NSLog(@"Result:%lld", result);
       file_exists = YES;

```

### Move value into Register ( x86_64 )
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
### Extended asm example ( x86_64 )
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
### Tips!
```
/* SIGSYS means call was wrong !*/

The registers in must use lowercase letters rather than uppercase letters.

Rememebr to specify a 64-int type ( i.e. int64_t ) if you get "value size does not match register size specified by the constraint and modifier".

```


##### References
https://developer.arm.com/documentation/100748/0606/Using-Assembly-and-Intrinsics-in-C-or-C---Code/Writing-inline-assembly-code

https://stackoverflow.com/questions/25431095/how-to-implement-system-call-in-arm64/50815683#50815683

http://labe.felk.cvut.cz/~stepan/33OSD/files/e1-syscalls-inline-asm.pdf

http://www.ethernut.de/en/documents/arm-inline-asm.html

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

https://www.ibm.com/developerworks/rational/library/inline-assembly-c-cpp-guide/index.html
