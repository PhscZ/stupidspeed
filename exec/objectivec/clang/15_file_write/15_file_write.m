// task 15 file_write -- expected output: 419430400
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 15_file_write.m -lobjc -lgnustep-base    run: ./prog
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
    unsigned char *chunk = malloc(1048576);
    for (int i = 0; i < 1048576; i++) chunk[i] = (unsigned char)(i % 256);
    NSData *buffer = [NSData dataWithBytes:chunk length:1048576];
    unsigned long long written = 0;
    for (int pass = 0; pass < 8; pass++) {
        [[NSFileManager defaultManager] createFileAtPath:@"out.bin" contents:nil attributes:nil];
        NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:@"out.bin"];
        for (int i = 0; i < 50; i++) {
            [fh writeData:buffer];
            written += 1048576;
        }
        [fh synchronizeFile];
        [fh closeFile];
    }
    ss_report(ss_t0);
    printf("%llu\n", written);
} return 0; }
