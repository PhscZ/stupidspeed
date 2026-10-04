// task 14 file_read -- expected output: 2389704704
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 14_file_read.m -lobjc -lgnustep-base    run: ./prog
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
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:@"data.bin"];
    unsigned long long total = 0;
    NSData *blk;
    while ((blk = [fh readDataOfLength:1048576]).length > 0) {
        const unsigned char *p = blk.bytes;
        NSUInteger len = blk.length;
        for (NSUInteger i = 0; i < len; i++) total = total + p[i];
    }
    [fh closeFile];
    ss_report(ss_t0);
    printf("%llu\n", total % 4294967296ULL);
} return 0; }
