// task 13 matrix_mul -- expected output: 599995000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 13_matrix_mul.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
/* timing: clock_gettime(CLOCK_MONOTONIC) is the monotonic clock, the same one the C row uses
   on Linux; TIME_MS goes to stderr and stdout is unchanged. */
#include <stdio.h>
#include <time.h>
static double ss_now_ms(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec * 1000.0 + (double)ts.tv_nsec / 1000000.0;
}
static void ss_report(double t0) {
    fprintf(stderr, "TIME_MS=%.3f\n", ss_now_ms() - t0);
}
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    double ss_t0 = ss_now_ms();
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
    ss_report(ss_t0);
    printf("%lld\n", sum);
    free(A); free(B); free(C);
} return 0; }
