# Assembler - compile ARM code for multiple O/S
##### References
http://kerseykyle.com/articles/ARM-assembly-hello-world

https://www.acmesystems.it/arm9_toolchain
##### Source code
```
#include <stdio.h>
#include <stdlib.h>

int main() {
    puts("Hello asm world");
    exit(99);
}
```
##### C -> ASM -> Object file -> Executable
```
// compile to assembly
gcc foo.c -S -o foo.s

// compile to object file
gcc -c foo.s -o foo.o

// linker step to final binary
gcc foo.o -o foo

```
##### ARM64 asm
```
$ cat foo.s
    .arch armv8-a
    .file    "foo.c"
    .section    .rodata
    .align    3
.LC0:
    .string    "Hello asm world"
    .text
    .align    2
    .global    main
    .type    main, %function
main:
    stp    x29, x30, [sp, -16]!
    add    x29, sp, 0
    adrp    x0, .LC0
    add    x0, x0, :lo12:.LC0
    bl    puts
    mov    w0, 99
    bl    exit
    .size    main, .-main
    .ident    "GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
    .section    .note.GNU-stack,"",@progbits
 ```
##### ARM64 Result
```
$ file foo
foo: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, for GNU/Linux 3.7.0, BuildID[sha1]=6960c778c8e946e25007f9b2fefff372f8045cd0, not stripped
```
##### Compile for 32bit ARM
On my 64-bit machine...

```
uname -m
aarch64
```
I had to install a cross-compiler.
```
sudo apt-get install gcc-arm-linux-gnueabi
sudo apt-get install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev
sudo apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf      // you need this for generic header files
```
After that, I was able to go straight from ARM32 code to an object file.
##### ASM -> Object file -> Executable
```
arm-linux-gnueabi-as hello.s -o hello.o

arm-linux-gnueabi-ld hello.o -o hello
```

##### ARM32 asm
```
.text            
.global _start
_start:
    mov r0, #1
    ldr r1, =message
    ldr r2, =len
    mov r7, #4
    swi 0

    mov r7, #1
    swi 0

.data
message:
    .asciz "hello world\n"
len = .-message     
```
##### Result
```
./hello
hello world

file hello
hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped
```
