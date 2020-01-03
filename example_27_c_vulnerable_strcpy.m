#include <stdio.h>
#include <string.h>

char* YDstrcpy(char* destination, const char* source)
{
    if (destination == NULL)
        return NULL;

    char *ptr = destination;

    while (*source != '\0')
    {
        *destination = *source;
        destination++;
        source++;
    }

    *destination = '\0';    // add the terminating null character
    return ptr;             // destination is returned by standard strcpy()
}


int main(int argc, char **argv)
{

    char source[] = "Hello";
    char destination1[6];
    char destination2[6];
    char *ptr_destination1 = NULL;
    char *ptr_destination2 = NULL;

    ptr_destination1 = YDstrcpy(destination1, source);
    ptr_destination2 = strcpy(destination2, source);
    printf("destination1    \t -> %s\n", destination1);
    printf("destination2    \t -> %s\n", destination2);
    printf("ptr_destination1\t -> %p\n", ptr_destination1);
    printf("ptr_destination1\t -> %p\n", ptr_destination2);

    return 0;
}
