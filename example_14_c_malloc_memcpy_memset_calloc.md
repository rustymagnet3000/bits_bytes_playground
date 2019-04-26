## Code
```
#include <stdio.h>      // printf
#include <stdlib.h>     // calloc, malloc
#include <string.h>     // memcpy
#define BUFFER_SIZE 1024
#define ANIMAL_OFFSET 100

enum Environment{RIVER, LAND, SEA};

typedef struct {
    char *name;
    enum Environment env;
    unsigned int eyes;
    unsigned int legs;
} YDAnimal;

int main() {

    char buffer[BUFFER_SIZE];
    const char *lonely_name = "Lars";

    // Heap
    YDAnimal *wolf_spider = malloc(sizeof(*wolf_spider));
    YDAnimal *garden_spider = malloc(sizeof(*garden_spider));
    YDAnimal *toebiter = calloc(1, sizeof(*toebiter));

    wolf_spider->legs = 8;
    wolf_spider->eyes = 4;
    wolf_spider->env = LAND;
    wolf_spider->name = "Boris";

    toebiter->legs = 6;
    toebiter->eyes = 2;
    toebiter->env = RIVER;
    toebiter->name = "Henry";

    // memcpy
    memcpy(garden_spider, wolf_spider, sizeof(YDAnimal));
    garden_spider->name = "Max";

    // Stack
    YDAnimal army_ant = { .eyes = 2, .env = LAND, .legs = 6, .name = "Dave"};
    YDAnimal bullet_ant = army_ant;
    YDAnimal *fire_ant; // no malloc for this pointer
    bullet_ant.name = "Fred";

    // memcpy && memset
    memset(buffer, 0, BUFFER_SIZE);
    memcpy(buffer+ANIMAL_OFFSET, &army_ant, sizeof(YDAnimal));
    fire_ant = (YDAnimal*)(buffer + ANIMAL_OFFSET);
    fire_ant->name = (char *) lonely_name;

    printf("Spiders:              \t\t%s|%s\n", wolf_spider->name, garden_spider->name);
    printf("Ants:                 \t\t%s|%s|%s\n", army_ant.name, bullet_ant.name, fire_ant->name);
    printf("Toebiter:             \t\t%s\n", toebiter->name);
    printf("Sizeof Struct ptr:   \t\t%lu\n", sizeof(wolf_spider));
    printf("Sizeof garden_spider:\t\t%lu\n", sizeof(*garden_spider));
    printf("Sizeof YDAnimal:     \t\t%lu\n", sizeof(YDAnimal));
    printf("Sizeof Char*:        \t\t%lu\n", sizeof(char*));
    printf("Sizeof Int:          \t\t%lu\n", sizeof(int));

    free(garden_spider);
    free(wolf_spider);
    free(toebiter);
    toebiter = wolf_spider = garden_spider = NULL;
    return 0;
}
```
## References
Jacob Sorber:  https://www.youtube.com/watch?v=NqUTiJPgBn8&t=12s

https://stackoverflow.com/questions/17258647/why-is-it-safer-to-use-sizeofpointer-in-malloc

https://www.lancaster.ac.uk/~simpsons/char/memory/dynamic

https://tia.mat.br/posts/2015/05/01/initializing_a_heap_allocated_structure_in_c.html
