# Syscall
##### Check for file existence
```
ACCESS(2)                   BSD System Calls Manual                  ACCESS(2)

NAME
     access -- check access permissions of a file or pathname

SYNOPSIS
     #include <unistd.h>

     int
     access(const char *path, int amode);
```
##### Using libC wrapper around Syscall
```
#include <stdio.h>
#include <unistd.h>

// #define F_OK            0       /* test for existence of file */

int main (void){
    int result = access("output.txt", F_OK);
    printf("[*] result: %d", result);
    return 0;
}
```
##### strace
```
$ gcc access2.c

$ file a.out
a.out: ELF 64-bit LSB shared object, ARM aarch64

$ ./a.out
[*] result: 0

$ strace ./a.out

  faccessat(AT_FDCWD, "output.txt", F_OK) = 0
  write(1, "[*] result: 0\n", 14[*] result: 0
  )         = 14
  exit_group(0)                           = ?
  +++ exited with 0 +++
```

##### Directly with Syscall
```
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

#define ACCESS 33

int main(void) {
    int result = syscall(ACCESS, "output.txt", F_OK);
    printf("[*] result: %d", result);
    return 0;
}
```
##### Registers for Syscalls
http://man7.org/linux/man-pages/man2/syscall.2.html
```

	Arch/ABI      arg1  arg2  arg3  arg4  arg5  arg6  arg7  Notes
       ──────────────────────────────────────────────────────────────
       arm/EABI      r0    r1    r2    r3    r4    r5    r6
       arm64         x0    x1    x2    x3    x4    x5    -
       i386          ebx   ecx   edx   esi   edi   ebp   -
```
##### References
```
http://shell-storm.org/shellcode/files/syscalls.html
https://filippo.io/linux-syscall-table/
https://modexp.wordpress.com/2017/01/21/shellcode-osx/
```
