// task 04 array_sum — expected output: 499999500000
// build: gcc -O2 -pthread -o prog main.c    run: ./prog
// alternates: clang -O2 -pthread -o prog main.c | cl /O2 /Fe:prog main.c | tcc -o prog main.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int main(void) {
    const int64_t n = 1000000;
    int64_t *array = (int64_t *)malloc((size_t)n * sizeof(int64_t));

    for (int64_t i = 0; i < n; i++) {
        array[i] = i;
    }

    int64_t total = 0;
    for (int64_t i = 0; i < n; i++) {
        total += array[i];
    }

    printf("%lld\n", (long long)total);
    free(array);
    return 0;
}
