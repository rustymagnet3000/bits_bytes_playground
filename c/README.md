# Bits and bytes

<!-- TOC depthfrom:2 depthto:4 withlinks:true updateonsave:true orderedlist:false -->

- [c](#c)
    - [c_3_malloc_memcpy_memset_calloc](#c_3_malloc_memcpy_memset_calloc)
    - [c_5_fork](#c_5_fork)
    - [c_6_bit_fields](#c_6_bit_fields)
    - [c_10_bitwise_operators](#c_10_bitwise_operators)
    - [c_15_threads_with_pthreads](#c_15_threads_with_pthreads)
    - [C Vulnerable strcpy](#c-vulnerable-strcpy)
    - [a.C Invoke shell from code](#ac-invoke-shell-from-code)
    - [b.ASM Shellcode for execve](#basm-shellcode-for-execve)
    - [ASM compile for ARM64 or ARM32](#asm-compile-for-arm64-or-arm32)
    - [C Syscall](#c-syscall)
    - [Writing in-line assembly code in C](#writing-in-line-assembly-code-in-c)

<!-- /TOC -->

## c

### c_3_malloc_memcpy_memset_calloc

This example covered `Structs` and how C offered the flexibility to init on the `heap` (with `malloc`,  and `calloc`) or `stack`  and simple techniques to initialise a `struct`.  This included using a `char buffer` with `memcpy` and `memset`.

### c_5_fork

The most basic example for C's Fork API.

### c_6_bit_fields

> tba

### c_10_bitwise_operators

Simple examples of the C bitwise operators.

### c_15_threads_with_pthreads

I enjoyed writing this code; I started two background threads.  Both printed a message to logs.  The goal was to use a debugger to `suspend thread`. But I ended up also trying to `kill thread`.



### 27.C Vulnerable strcpy
On macOS the linker defaults to swap out a vulnerable `strcpy` with a safe version.  This code is designed to be unsafe to demo the issues with `buffer overflows` and `strcpy`.

### 28a.C Invoke shell from code
The simplest example of C's `execve` to transform the calling process into a new process.  This example showed how to spawn a bash shell from code.

### 28b.ASM Shellcode for execve
Transform the `asm` code into shellcode.  Only for `arm` hosts.

### 29.ASM compile for ARM64 or ARM32
This write-up shows how to compile source code or ASM code on a 64-bit ARM machine for either 64 or 32 bit targets.  I had to install a `cross-compiler`.

### 30.C Syscall
Circumvent `libC` and directly invoke the Operating System with `Syscall` on `macOS` and `linux`.

### 31.Writing in-line assembly code in C
Write ASM instructions inside of C code for Linux ARM.
