// task 12 matrix_add -- expected output: 999000000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 12_matrix_add.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    int n = 1000;
    int *A = malloc(sizeof(int) * n * n);
    int *B = malloc(sizeof(int) * n * n);
    int *C = malloc(sizeof(int) * n * n);
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) { A[i*n+j] = i + j; B[i*n+j] = i - j; }
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) C[i*n+j] = A[i*n+j] + B[i*n+j];
    long long sum = 0;
    for (int i = 0; i < n * n; i++) sum += C[i];
    printf("%lld\n", sum);
    free(A); free(B); free(C);
} return 0; }
