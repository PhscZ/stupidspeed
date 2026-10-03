// task 12 matrix_add — expected output: 999000000
// build: gcc -O2 -pthread -o prog 12_matrix_add.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 12_matrix_add.c | cl /O2 /Fe:prog 12_matrix_add.c | tcc -o prog 12_matrix_add.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int main(void) {
    const int64_t n = 1000;
    const size_t elems = (size_t)(n * n);

    int64_t *A = (int64_t *)malloc(elems * sizeof(int64_t));
    int64_t *B = (int64_t *)malloc(elems * sizeof(int64_t));
    int64_t *C = (int64_t *)malloc(elems * sizeof(int64_t));

    for (int64_t i = 0; i < n; i++) {
        for (int64_t j = 0; j < n; j++) {
            A[i * n + j] = i + j;
            B[i * n + j] = i - j;
        }
    }

    for (int64_t i = 0; i < n; i++) {
        for (int64_t j = 0; j < n; j++) {
            C[i * n + j] = A[i * n + j] + B[i * n + j];
        }
    }

    int64_t total = 0;
    for (size_t k = 0; k < elems; k++) {
        total += C[k];
    }

    printf("%lld\n", (long long)total);
    free(A);
    free(B);
    free(C);
    return 0;
}
