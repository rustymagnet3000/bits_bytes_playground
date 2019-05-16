#include <pthread.h>
#include <stdio.h>

/*********************************************************************************
 Start two background threads.
 Both print a message to logs.
 Goal 1: use pthread_join to main thread waits for background threads to finish
 *********************************************************************************/

typedef struct{
    int count;
    char *message;
}Chomper;

void *hello_world(void *voidptr) {
    uint64_t tid;
    assert(pthread_threadid_np(NULL, &tid)== 0);
    printf("Thread ID: dec:%llu hex: %#08x\n", tid, (unsigned int) tid);
    Chomper *chomper = (Chomper *)voidptr;  // help the compiler understand how tochange the void pointer to the actual data structure
    
    for (int i = 0; i < chomper->count; i++) {
        sleep(1);
        printf("%s: %d\n", chomper->message, i);
    }
    return NULL;
}

int main() {
    @autoreleasepool {
      
        pthread_t myThread1 = NULL, myThread2 = NULL;
        
        Chomper *shark = malloc(sizeof(*shark));
        shark->count = 5;
        shark->message = "hello";

        Chomper *jellyfish = malloc(sizeof(*jellyfish));
        jellyfish->count = 20;
        jellyfish->message = "goodbye";

        assert(pthread_create(&myThread1, NULL, hello_world, (void *) shark) == 0);
        assert(pthread_create(&myThread2, NULL, hello_world, (void *) jellyfish) == 0);
        assert(pthread_join(myThread1, NULL) == 0);
        assert(pthread_join(myThread2, NULL) == 0);
    }
    return 0;
}
