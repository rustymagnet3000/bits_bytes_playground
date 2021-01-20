i#include <stdio.h>

int changeme = 255;

static void print_canary(void)__attribute__ ((destructor));

int main(int argc, char **argv) {
  exit(0);
}

void print_canary(void)
{
    printf("Canary at: %d\t:%p", changeme, &changeme);
}
