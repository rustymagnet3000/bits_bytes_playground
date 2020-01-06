# Syscall
##### Example API
```
ACCESS(2)                   BSD System Calls Manual                  ACCESS(2)

NAME
     access -- check access permissions of a file or pathname

SYNOPSIS
     #include <unistd.h>

     int access(const char *path, int amode);
```
##### Normal libC wrapper
```
#include <stdio.h>
#include <unistd.h>

int main (void){
    int result = access("output.txt", F_OK);  /* test existence of file */
    printf("[*] result: %d\n", result);
    return 0;
}
```           
##### Using Syscall (Linux)
```
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <fcntl.h> /* Definition of AT_* constants */

int main(void) {
        int result = syscall(SYS_faccessat, AT_FDCWD, "output.txt", F_OK);
        printf("[*] result: %d\n", result);
        return 0;
}
```
##### Using Syscall (macOS)
```
int main(void) {
    int result = syscall(SYS_access, "output.txt", F_OK);
    printf("[*] result: %d\n", result);
    return 0;
}
```
##### Finding syscall number
On macOS - with xCode - you could find syscall values in: **/usr/include/sys/syscall.h**.

```
//macOS
#define	SYS_syscall        0
#define	SYS_exit           1
#define	SYS_fork           2
#define	SYS_read           3
#define	SYS_write          4
...
...
#define	SYS_access         33
```
On Linux, I preferred to add a compiler flag:

`gcc -H foobar.c`

Then `gcc` printed the file path of each included files.  On my `Linux-ARM-emulator`, I followed the breadcrumbs to:

`/usr/include/aarch64-linux-gnu/bits/syscall.h`

##### Use SYS_
The syscall value depended on the O/S.  For example, the system call to check a file exists (`access`) is:

- `33 on macOS`
- `21 on linux`

This is normally handled by `libC` for you.  But as you calling `syscall` directly you need to know which number to use.



##### dtruss (macOS)
```
dtruss ./C_Playground
open("/dev/dtracehelper\0", 0x2, 0xFFFFFFFFE2E06F10)		 = 3 0
access("/AppleInternal/XBS/.isChrooted\0", 0x0, 0x0)		 = -1 Err#2
access("output.txt\0", 0x0, 0x0)		 = 0 0
write_nocancel(0x1, "[*] result: 0\n\0", 0xE)		 = 14 0
```

##### strace (Linux)
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
##### why faccessat?
When I originally called `access` on Linux, it was auto-changed my code to this instruction:
https://linux.die.net/man/2/faccessat

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
https://jameshfisher.com/2018/02/19/how-to-syscall-in-c/
http://shell-storm.org/shellcode/files/syscalls.html
https://filippo.io/linux-syscall-table/
https://modexp.wordpress.com/2017/01/21/shellcode-osx/
```
