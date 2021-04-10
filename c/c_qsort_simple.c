#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_INTS 6

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int main (int argc, char *argv[]) {
    unsigned int i = 0;
    int numbers[MAX_INTS] = { 1, 3, 6, 4, 1, 2 };
    
    puts ("Before sorting the list: \n");
    for (i = 0; i < MAX_INTS; i++) {
        printf("%d\t", numbers[i]);
    }
    
    qsort (numbers, MAX_INTS, sizeof(int), cmpfunc);
    puts ("\n\nAfter sorting the list: \n");
    for (i = 0 ; i < MAX_INTS; i++ ) {
        printf("%d\t", numbers[i]);
    }
    putchar('\n');
    
    return EXIT_SUCCESS;
}


/*
Before sorting the list: 

1	3	6	4	1	2	

After sorting the list: 

1	1	2	3	4	6	
*/
