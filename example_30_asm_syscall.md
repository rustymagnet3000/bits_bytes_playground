# Assembler - compile ARM code for multiple O/S
##### References
```
https://w3challs.com/syscalls/?arch=arm_strong  // find the Syscall here
https://github.com/azeria-labs/ARM-assembly-examples/blob/master/write.s // example code
```
##### ASM code
```
.data
string: .asciz "Foobar World\n"  @ .asciz adds a null-byte to the end of the string
after_string:
.set size_of_string, after_string - string

.text
.global _start

_start:
   mov r0, #1               @ STDOUT
   ldr r1, addr_of_string   @ memory address of string
   mov r2, #size_of_string  @ size of string
   mov r7, #4               @ write syscall
   swi #0                   @ invoke syscall

_exit:
   mov r7, #1               @ exit syscall
   swi 0                    @ invoke syscall

addr_of_string: .word string
```

##### ASM -> Object file -> Executable
```
arm-linux-gnueabi-as access.s -o access.o && arm-linux-gnueabi-ld access.o -o access
```
##### Result
```
user@arm64:~$ ./access

```
