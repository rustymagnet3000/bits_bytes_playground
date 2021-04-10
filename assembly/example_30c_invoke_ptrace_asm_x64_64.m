#import <Foundation/Foundation.h>
/*
https://alexomara.com/blog/defeating-anti-debug-techniques-macos-ptrace-variants/
https://cardaci.xyz/blog/2018/02/12/a-macos-anti-debug-technique-using-ptrace/
*/

@interface Foo : NSObject       @end
@implementation Foo
+(void)asmStartDenyAttach {
    NSLog (@"[*]ASM code starting...");
    asm("movq $0, %rcx");
    asm("movq $0, %rdx");
    asm("movq $0, %rsi");
    asm("movq $0x1f, %rdi");      /* PT_DENY_ATTACH 31 (0x1f)*/
    asm("movq $0x200001a, %rax"); /* ptrace syscall number 26 (0x1a) */
    asm("syscall");
}

@end

int main (void) {
    NSLog (@"[*]Program starting..");
    [Foo asmStartDenyAttach];
    NSLog (@"[*]Program completing");
    return 0;
}


/*
 BREAKPOINTS WON"T FIRE
 (lldb) b syscall
 Breakpoint 2: where = libsystem_kernel.dylib`__syscall, address = 0x00007fff721469f0
 
 
 
 ## Patching with Ghidra
 /Search/Memory
 Type in decimal value    :    31
 Or type in Hex value     :    0x1f


 ## Testing the patch
 You require a debugger attached to check the patch worked:
 ▶ lldb
 (lldb) target create objc_play
 (lldb) r

 */

nm objc_playground
0000000100000ef0    t +[Foo load]
                    U _NSLog
                    // no mention of ptrace Symbol

lldb objc_playground

 (lldb) r
 Process 39117 launched:
 -- LOAD
 Process 39117 exited with status = 45 (0x0000002d)



 dtrace -q -n 'syscall:::entry /pid == $target && probefunc == "ptrace"/ { ustack(); }' -c $playpath/objc_playground_2
[*]LOAD
[*]Program completing, success

*/
