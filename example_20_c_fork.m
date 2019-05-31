#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <sys/types.h>

int main(int argc, char *argv[], char *envp[]) {
    
    int id;
    id = fork();
    printf("[+] id value : %d\n",id);
    if ( id == 0 )
    {
        printf ( "[+] I am the child process\n");
        printf ( "[+] Child’s PID: %d\n", getpid());
        printf ( "[+] Parent’s PID: %d\n", getppid());
        for (int i = 0; envp[i] != NULL; i++) {
            printf("[+] ]%s\n", envp[i]);
        }
    }
    
    return 0;
}

