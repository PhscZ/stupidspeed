// task 09 fib_recursive -- expected output: 102334155
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 09_fib_recursive.m -lobjc -lgnustep-base    run: ./prog
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
__attribute__((noinline)) static long long fib(long long n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}
int main(void) { @autoreleasepool {
    double ss_t0 = ss_now_ms();
    /* the work is evaluated into a variable first: computing it inside the printf argument
       list would place all 331 million calls after the timer stops. */
    long long ss_r = fib(40);
    ss_report(ss_t0);
    printf("%lld\n", ss_r);
} return 0; }
