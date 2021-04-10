void banner(void){
    char c = '*';
    int count = 42;
    for (int i = 0; i < count; i ++) {
        putchar(c);
    }
    putchar('\n');
}

int main(void) {
    
    const int int_arr[5] = {1,2,3,4,5};
    size_t elements_of_arr = sizeof(int_arr)/sizeof(int_arr[0]);
    
    printf("[*]sizeof int_arr\t\t%lu\n", sizeof(int_arr));
    printf("[*]elements int_arr\t\t%lu\n", elements_of_arr);
    banner();
    
    
    // Pointer to first element within int array
    const int *p;
    p = &int_arr[0];                                    // or: p = int_arr;
    printf("[*]sizeof p       \t\t%lu\n", sizeof(p));
    printf("[*]p points toward \t\t%p\n", p);
    for (int i = 0; i < elements_of_arr; i++)
    {
        printf("%p\t\t\t\t= %d\n", p, *p);
        p++;
    }
    banner();
    
    
    // pointer to entire integer array. You set the size.
    const int (*ptr_int_arr)[5] = &int_arr;
    const int *ptr_end_int_arr = &int_arr[elements_of_arr];  // or: ptr_int_arr + 5
    printf("[*]sizeof int_arr_ptr\t%lu\n", sizeof(ptr_int_arr));
    printf("[*]Start   \t\t\t\t%p\n", ptr_int_arr);
    printf("[*]End     \t\t\t\t%p\n", ptr_end_int_arr);

    printf("[*]Start ( by memory address )\t\t%p\n", &ptr_int_arr);
    printf("[*]End ( by memory address )  \t\t%p\n", &ptr_end_int_arr);
    for (int *curr = (int*)ptr_int_arr; curr != ptr_end_int_arr; curr++)
        printf("%p\t\t\t\t= %d\n", curr, *curr);
    banner();
    
    long difference = ptr_end_int_arr - (int *)ptr_int_arr;
    printf("[*]Pointer arithmetic\n");
    printf("[*]elements \t\t\t\t%lu\n", difference);
    printf("[*]elements * sizeof(int)\t%ld\n", difference * sizeof(int));
    
    return 0;
}

/*
 [*]sizeof int_arr        20
 [*]elements int_arr        5
 ******************************************
 [*]sizeof p               8
 [*]p points toward         0x1039bde60
 0x1039bde60                = 1
 0x1039bde64                = 2
 0x1039bde68                = 3
 0x1039bde6c                = 4
 0x1039bde70                = 5
 ******************************************
 [*]sizeof int_arr_ptr    8
 [*]Start                   0x1039bde60
 [*]End                     0x1039bde74
 [*]Start ( by memory address )        0x7ffeec2426b8
 [*]End ( by memory address )          0x7ffeec2426b0
 0x1039bde60                = 1
 0x1039bde64                = 2
 0x1039bde68                = 3
 0x1039bde6c                = 4
 0x1039bde70                = 5
 ******************************************
 [*]Pointer arithmetic
 [*]elements                 5
 [*]elements * sizeof(int)    20
 
 */
