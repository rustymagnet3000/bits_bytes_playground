#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <dlfcn.h>
#define STR_LEN 10

/* "needle" with calloc(10) == 6e 65 65 64 6c 65 00 00 00 00 */
/* https://blog.holbertonschool.com/hack-the-virtual-memory-malloc-the-heap-the-program-break/ */


int main() {

    void *handle;
    int *sysaddr;
    int *extaddr;
    
    handle = dlopen(NULL, RTLD_LOCAL);
    *(void **)(&sysaddr) = dlsym(handle, "system");
    sysaddr += 4096;
    printf("system()\tat %p\n", sysaddr);

    *(void **)(&extaddr) = dlsym(handle, "exit");
    extaddr += 4096;
    printf("exit()  \tat %p\n", extaddr);
    
    const char *needle = "needle";
    char *str = calloc (STR_LEN, sizeof (char));
    
    strncpy (str, needle, STR_LEN);
    printf ("str ptr:   \t%p\nTarget str:\t", str);
    
    unsigned int i = 0;
    do {
        putchar (str[i]);
        i++;
    } while (str[i] != '\0');

    putchar ('\n');

    free (str);
    return EXIT_SUCCESS;
}

