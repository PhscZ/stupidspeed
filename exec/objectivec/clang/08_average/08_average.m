// task 08 average -- expected output: 0.498046875
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 08_average.m -lobjc -lgnustep-base    run: ./prog
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
    double total = 0.0;
    for (long long i = 0; i < 100000000LL; i++) {
        double reading = (double)(i % 256) / 256.0;
        total = total + reading;
    }
    ss_report(ss_t0);
    printf("%.9f\n", total / 100000000.0);
} return 0; }
