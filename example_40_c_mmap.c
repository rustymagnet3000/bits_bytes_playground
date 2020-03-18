#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

/*
 PROT_EXEC     Pages may be executed.
 PROT_READ     Pages may be read.
 PROT_WRITE    Pages may be written.
 PROT_NONE     Pages may not be accessed.
 
 */
int main(void) {
    
    size_t pagesize = getpagesize();            // same as: (size_t) sysconf (_SC_PAGESIZE);
    printf("[+]System pagesize: %zu bytes\n", pagesize);

    char *region = mmap(
                         (void*)0xDEADBEEF,      // Try to put memory at this address
                         pagesize,  // for one pagesize
                         PROT_READ|PROT_WRITE,
                         MAP_ANONYMOUS|MAP_PRIVATE,             // tell kernal how we want to manage memory
                         0, 0);
    if (region == MAP_FAILED) {
        perror("Could not mmap");
        return 1;
    }

    strcpy(region, "Hello, world");
    printf("[+]Pointer:\t\t\t%p\n[+]Region:\t\t\t%s\n", region, region);

    int unmap_result = munmap(region, pagesize);
    if (unmap_result != 0) {
        perror("Could not munmap");
        return 1;
    }
    puts("[+]bye bye");
    return 0;
}

/*
 
dtruss ./C_Playground

write_nocancel(0x1, "[+]System pagesize: 4096 bytes\n\0", 0x1F)         = 31 0
mmap(0xDEADBEEF, 0x1000, 0x7, 0x1002, 0x0, 0x0)         = 0x10EBAE000 0
write_nocancel(0x1, "[+]Pointer:\t\t\t0x10ebae000\n\0", 0x1A)         = 26 0
write_nocancel(0x1, "[+]Region:\t\t\tHello, world\n\0", 0x1A)         = 26 0
munmap(0x10EBAE000, 0x400)         = 0 0
write_nocancel(0x1, "[+]bye bye\n\0", 0xB)         = 11 0

*/

