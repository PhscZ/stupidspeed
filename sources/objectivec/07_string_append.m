// task 07 string_append -- expected output: 250000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 07_string_append.m -lobjc -lgnustep-base    run: ./prog
// Each append allocates a new buffer and copies the complete prior text, which is the
// quadratic copy the task measures. The bytes are held in a plain malloc'd buffer rather
// than an NSString: stringByAppendingString: returns an autoreleased object, so 250000
// intermediate strings would stay alive in the enclosing autorelease pool and the run
// would exhaust memory long before the loop finished. The C row's realloc plus strcat is
// the same shape.
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
#include <stdlib.h>
#include <string.h>
int main(void) { @autoreleasepool {
    double ss_t0 = ss_now_ms();
    char *text = malloc(1);
    size_t length = 0;
    text[0] = '\0';
    for (int i = 0; i < 250000; i++) {
        char *next = malloc(length + 2);
        memcpy(next, text, length);
        next[length] = 'x';
        next[length + 1] = '\0';
        free(text);
        text = next;
        length++;
    }
    ss_report(ss_t0);
    printf("%lu\n", (unsigned long)length);
    free(text);
} return 0; }
