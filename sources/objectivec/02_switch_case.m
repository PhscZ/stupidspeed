// task 02 switch_case -- expected output: 7500000075000000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 02_switch_case.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    long long acc = 0;
    for (long long i = 0; i < 100000000LL; i++) {
        switch (i % 4) {
            case 0: acc = acc + 1;     break;
            case 1: acc = acc + i;     break;
            case 2: acc = acc + 2 * i; break;
            case 3: acc = acc + 3 * i; break;
        }
    }
    printf("%lld\n", acc);
} return 0; }
