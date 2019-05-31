#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
/*********************************************************************************
 Start two background threads.
 Both print a message to logs.
 Goal: pause / exit the calling thread why the other thread continues
 *********************************************************************************/
const unsigned int microseconds = 10;

typedef struct{
    int count;
    char *message;
}Chomper;

void *hello_world(void *voidptr) {
    uint64_t tid;

    assert(pthread_threadid_np(NULL, &tid)== 0);
    printf("Thread ID: dec:%llu hex: %#08x\n", tid, (unsigned int) tid);
    Chomper *chomper = (Chomper *)voidptr;  // help the compiler map the void pointer to the actual data structure

    for (int i = 0; i < chomper->count; i++) {
        usleep(microseconds);
        printf("%s: %d\n", chomper->message, i);
    }
    return NULL;
}

int main() {

    pthread_t myThread1 = NULL, myThread2 = NULL;

    Chomper *shark = malloc(sizeof(*shark));
    shark->count = 5;
    shark->message = "shark";

    Chomper *jellyfish = malloc(sizeof(*jellyfish));
    jellyfish->count = 5;
    jellyfish->message = "jelly";

    assert(pthread_create(&myThread1, NULL, hello_world, (void *) shark) == 0);
    assert(pthread_create(&myThread2, NULL, hello_world, (void *) jellyfish) == 0);
    assert(pthread_join(myThread1, NULL) == 0);
    assert(pthread_join(myThread2, NULL) == 0);

    free(shark);
    free(jellyfish);
    shark = NULL;
    jellyfish = NULL;

    return 0;
}

/*
[+] ORIGINAL
 Thread ID: dec:40712 hex: 0x009f08
 Thread ID: dec:40713 hex: 0x009f09
 shark: 0
 jelly: 0
 shark: 1
 jelly: 1
 shark: 2
 jelly: 2
 shark: 3
 jelly: 3
 shark: 4
 jelly: 4

 [+] GOAL
 jelly: 0
 jelly: 1
 jelly: 2
 jelly: 3
 jelly: 4

 */
