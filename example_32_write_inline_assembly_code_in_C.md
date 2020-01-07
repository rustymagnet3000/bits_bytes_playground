# Writing in-line assembly code in C
##### Scope
This works for ARM on Linux.
##### Template
```
/* Extended inline assembly syntax */
__asm [volatile] (code_template
       : output_operand_list
      [: input_operand_list
      [: clobbered_register_list]]
  );
```
##### Original call
```
// Example from: http://infocenter.arm.com/
#include <stdio.h>

int add(int i, int j)
{
  int res = 0;
  __asm ("ADD %[result], %[input_i], %[input_j]"
    : [result] "=r" (res)
    : [input_i] "r" (i), [input_j] "r" (j)
  );
  return res;
}

int main(void)
{
  int a = 1;
  int b = 2;
  int c = 0;

  c = add(a,b);

  printf("Result of %d + %d = %d\n", a, b, c);
}
```
##### Registers for Syscalls
```
// source: http://man7.org/linux/man-pages/man2/syscall.2.html

	 Arch/ABI      arg1  arg2  arg3  arg4  arg5  arg6  arg7  Notes
       ──────────────────────────────────────────────────────────────
       arm/EABI      r0    r1    r2    r3    r4    r5    r6
       arm64         x0    x1    x2    x3    x4    x5    -
       i386          ebx   ecx   edx   esi   edi   ebp   -
```
##### References
```
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.100748_0606_00_en/ddx1471430827125.html
http://www.ethernut.de/en/documents/arm-inline-asm.html
https://jameshfisher.com/2018/02/19/how-to-syscall-in-c/
https://www.i-programmer.info/programming/cc/13240-applying-c-assembler.html
https://cs.lmu.edu/~ray/notes/gasexamples/
```
