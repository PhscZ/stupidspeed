// task 03 func_sum -- expected output: 100000000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 03_func_sum.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
__attribute__((noinline)) static long long add_one(long long n) { return n + 1; }
int main(void) { @autoreleasepool {
    long long value = 0;
    for (long long i = 0; i < 100000000LL; i++) value = add_one(value);
    printf("%lld\n", value);
} return 0; }
