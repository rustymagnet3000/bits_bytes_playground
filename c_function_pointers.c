typedef int (*operator_ptr)(int,int);

int add (int a, int b) {return a + b;}
int mult (int c, int d) {return c * d;}

int do_messy_operation(int (*op)(int,int), int x, int y){
    return op(x,y);
}

int do_tidy_operation(operator_ptr op, int x, int y){
    return op(x,y);
}
int main(void) {
    
    int x = 10;
    int y = 5;
    int resultA = 0;
    int resultB = 0;
    resultA = do_messy_operation(add, x, y);
    resultB = do_tidy_operation(mult, x, y);
    printf("[*] Results: %d\t%d\n\n", resultA, resultB);
    return EXIT_SUCCESS;
}

