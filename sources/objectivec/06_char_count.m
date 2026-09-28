// task 06 char_count -- expected output: 10000000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 06_char_count.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
#include <string.h>
int main(void) { @autoreleasepool {
    const NSUInteger totalLength = 100000000;
    const char unit[] = "abcdefghij";
    NSMutableData *data = [NSMutableData dataWithLength:totalLength];
    unsigned char *bytes = [data mutableBytes];
    memcpy(bytes, unit, sizeof(unit) - 1);
    NSUInteger filled = sizeof(unit) - 1;
    while (filled < totalLength) {
        NSUInteger chunk = filled < totalLength - filled ? filled : totalLength - filled;
        memcpy(bytes + filled, bytes, chunk);
        filled += chunk;
    }
    NSString *text = [[NSString alloc] initWithBytes:bytes length:totalLength encoding:NSASCIIStringEncoding];
    long long count = 0;
    NSUInteger n = [text length];
    unichar *buf = malloc(n * sizeof(unichar));
    [text getCharacters:buf range:NSMakeRange(0, n)];
    for (NSUInteger i = 0; i < n; i++) {
        unichar ch = buf[i];
        if (ch == 'a') continue;
        else if (ch == 'e') continue;
        else if (ch == 'h') count = count + 1;
    }
    free(buf);
    printf("%lld\n", count);
} return 0; }
