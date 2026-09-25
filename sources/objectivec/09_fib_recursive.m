// task 09 fib_recursive -- expected output: 102334155
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 09_fib_recursive.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
__attribute__((noinline)) static long long fib(long long n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}
int main(void) { @autoreleasepool {
    printf("%lld\n", fib(40));
} return 0; }
