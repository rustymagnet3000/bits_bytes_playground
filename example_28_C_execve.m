#include <unistd.h>

int main() {
        char *args[2];
        args[0] = "/bin/sh";
        args[1] = NULL;
        execve(args[0], args, NULL);
}

// this will spawn a shell, after running
// https://azeria-labs.com/writing-arm-shellcode/
// http://www.kernel-panic.it/security/shellcode/shellcode5.html
// http://shell-storm.org/blog/Shellcode-On-ARM-Architecture/
