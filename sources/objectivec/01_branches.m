// task 01 branches -- expected output: 33333334 13333333 7619048 45714285
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 01_branches.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    long long a = 0, b = 0, c = 0, d = 0;
    for (long long i = 0; i < 100000000LL; i++) {
        if (i % 3 == 0) a++;
        else if (i % 5 == 0) b++;
        else if (i % 7 == 0) c++;
        else d++;
    }
    printf("%lld %lld %lld %lld\n", a, b, c, d);
} return 0; }
