// task 01 branches -- expected output: 33333334 13333333 7619048 45714285
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 01_branches.m -lobjc -lgnustep-base    run: ./prog
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
    long long a = 0, b = 0, c = 0, d = 0;
    for (long long i = 0; i < 100000000LL; i++) {
        if (i % 3 == 0) a++;
        else if (i % 5 == 0) b++;
        else if (i % 7 == 0) c++;
        else d++;
    }
    ss_report(ss_t0);
    printf("%lld %lld %lld %lld\n", a, b, c, d);
} return 0; }
