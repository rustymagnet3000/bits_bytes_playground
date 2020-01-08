# ARM shellcode for launching a shell
##### arm32 asm
https://github.com/azeria-labs/ARM-assembly-examples/blob/master/execve1.s

`int  execve(const char *filename, char *const argv [], char *const envp[]);`

```
.section .text
.global _start

_start:
        add r0, pc, #12     @r0 = pc + 12 ("/bin/sh\0")
        mov r1, #0          @pass NULL into the argv[]
        mov r2, #0          @pass NULL into the envp[]
        mov r7, #11         @11 is syscall number of execve on linux arm
        svc #0

.ascii "/bin/sh\0"
.ascii "/bin/ls -l\0"
```
# Banana skin
Why `pc + 12`?  Effective PC starts two instructions ahead of the current one. Great details here: https://azeria-labs.com/arm-data-types-and-registers-part-2/

##### Compile on arm64 host
```
arm-linux-gnueabi-as -c execve.s -o execve.o
arm-linux-gnueabi-ld tiny.o -o tiny
```
##### Runtime
```
$ ./tiny
$ exit              <-- new shell
user@arm64:~$       <-- original shell
```
##### Removing Null bytes
```
```
##### References
```
https://azeria-labs.com/writing-arm-shellcode/
http://www.kernel-panic.it/security/shellcode/shellcode5.html
http://shell-storm.org/blog/Shellcode-On-ARM-Architecture/
https://modexp.wordpress.com/2017/01/21/shellcode-osx/
```
