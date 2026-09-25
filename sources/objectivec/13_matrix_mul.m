// task 13 matrix_mul -- expected output: 599995000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 13_matrix_mul.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    int n = 500;
    int *A = malloc(sizeof(int) * n * n);
    int *B = malloc(sizeof(int) * n * n);
    int *C = malloc(sizeof(int) * n * n);
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) { A[i*n+j] = (i + j) % 7; B[i*n+j] = (i * j) % 5; }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int sum = 0;
            for (int k = 0; k < n; k++) sum = sum + A[i*n+k] * B[k*n+j];
            C[i*n+j] = sum;
        }
    }
    long long sum = 0;
    for (int i = 0; i < n * n; i++) sum += C[i];
    printf("%lld\n", sum);
    free(A); free(B); free(C);
} return 0; }
