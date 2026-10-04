// task 04 array_sum -- expected output: 499999500000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 04_array_sum.m -lobjc -lgnustep-base    run: ./prog
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
    long long *array = malloc(sizeof(long long) * 1000000);
    for (long long i = 0; i < 1000000; i++) array[i] = i;
    long long total = 0;
    for (long long i = 0; i < 1000000; i++) total = total + array[i];
    ss_report(ss_t0);
    printf("%lld\n", total);
    free(array);
} return 0; }
