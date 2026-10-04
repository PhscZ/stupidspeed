// task 05 alloc_churn -- expected output: 1274991808
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 05_alloc_churn.m -lobjc -lgnustep-base    run: ./prog
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
    long long total = 0;
    unsigned char *slots[256];
    for (int i = 0; i < 256; i++) slots[i] = NULL;
    for (long long i = 0; i < 10000000LL; i++) {
        unsigned char *buf = malloc(64);
        buf[0] = (unsigned char)(i % 256);
        total = total + buf[0];
        int slot = (int)(i % 256);
        if (slots[slot]) free(slots[slot]);
        slots[slot] = buf;
    }
    for (int i = 0; i < 256; i++) free(slots[i]);
    ss_report(ss_t0);
    printf("%lld\n", total);
} return 0; }
