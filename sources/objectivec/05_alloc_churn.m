// task 05 alloc_churn -- expected output: 1274991808
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 05_alloc_churn.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
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
    printf("%lld\n", total);
} return 0; }
