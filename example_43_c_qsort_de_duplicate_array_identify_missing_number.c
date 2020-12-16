#include <stdio.h>
#include <string.h>
#include <stdlib.h>
/*
     Write a function:
     For example, given A = [1, 3, 6, 4, 1, 2], the function should return 5.
     Given A = [1, 2, 3], the function should return 4.
     Given A = [−1, −3], the function should return 1.
 */

int
cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int
find_gap_in_sorted_array(int *array, int array_len){
    
    int n = 0;
    int dedup_array[array_len];
    int unique_count = 0;
    
    do {        /* remove duplicates */
        if ( array[n] != array[n + 1] ){
            dedup_array[unique_count] = array[unique_count + n];
            unique_count++;
        } else if (array[n] == array[n+1])
            n++;
            
    } while (unique_count + n < array_len);

    puts ("\n\nDe-depulicated array: \n");
    for (int i = 0; i < unique_count; i++) {
        printf("%d\t", dedup_array[i]);
    }
    
    int total;
    total = (unique_count + 1) * (unique_count + 2) / 2;
    for (int y = 0; y < unique_count; y++)
        total -= dedup_array[y];
    return total;
}

int
solution(int *A, int N) {            // code example was marked as int []. But it decays to an int*

    int i;
    
    qsort (A, N, sizeof(int), cmpfunc);
    puts ("\n\nAfter sorting the array: \n");
    for (i = 0 ; i < N; i++ ) {
        printf("%d\t", A[i]);
    }
    
    int top_value = A[N - 1];
    
    if (top_value > 0){
        return find_gap_in_sorted_array(A, N);
    }
    else if (top_value <= 0)
        return 1;
    else
        return 0;
}


int main (int argc, char *argv[]) {

    int array_a[] = { 1, 3, 6, 4, 1, 2 };
    int array_b[] = { 1, 2, 3 };
    int array_c[] = { -1, -3 };
    
    int result = solution(array_a, sizeof(array_a) / sizeof(array_a[0]));
    printf("\nTest 1:\t%s\tretvalue:%d\n", result == 5 ? "pass" : "fail", result);
    
    result = solution(array_b, sizeof(array_b) / sizeof(array_b[0]));
    printf("\nTest 2:\t%s\tretvalue:%d\n", result == 4 ? "pass" : "fail", result);

    result = solution(array_c, sizeof(array_c) / sizeof(array_c[0]));
    printf("\nTest 3:\t%s\tretvalue:%d\n", result == 1 ? "pass" : "fail", result);
    
    return EXIT_SUCCESS;
}


/*
After sorting the array: 

1	1	2	3	4	6	

De-depulicated array: 

1	2	3	4	6	
Test 1:	pass	retvalue:5


After sorting the array: 

1	2	3	

De-depulicated array: 

1	2	3	
Test 2:	pass	retvalue:4


After sorting the array: 

-3	-1	
Test 3:	pass	retvalue:1
*/
