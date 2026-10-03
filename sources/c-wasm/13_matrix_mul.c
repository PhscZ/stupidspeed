// task 13 matrix_mul — expected output: 599995000
// build: gcc -O2 -pthread -o prog 13_matrix_mul.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 13_matrix_mul.c | cl /O2 /Fe:prog 13_matrix_mul.c | tcc -o prog 13_matrix_mul.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int main(void) {
    const int64_t n = 500;
    const size_t elems = (size_t)(n * n);

    int64_t *A = (int64_t *)malloc(elems * sizeof(int64_t));
    int64_t *B = (int64_t *)malloc(elems * sizeof(int64_t));
    int64_t *C = (int64_t *)malloc(elems * sizeof(int64_t));

    for (int64_t i = 0; i < n; i++) {
        for (int64_t j = 0; j < n; j++) {
            A[i * n + j] = (i + j) % 7;
            B[i * n + j] = (i * j) % 5;
        }
    }

    /* plain i, j, k triple loop, in that order */
    for (int64_t i = 0; i < n; i++) {
        for (int64_t j = 0; j < n; j++) {
            int64_t sum = 0;
            for (int64_t k = 0; k < n; k++) {
                sum += A[i * n + k] * B[k * n + j];
            }
            C[i * n + j] = sum;
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
