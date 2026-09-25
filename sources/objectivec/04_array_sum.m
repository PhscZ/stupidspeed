// task 04 array_sum -- expected output: 499999500000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 04_array_sum.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    long long *array = malloc(sizeof(long long) * 1000000);
    for (long long i = 0; i < 1000000; i++) array[i] = i;
    long long total = 0;
    for (long long i = 0; i < 1000000; i++) total = total + array[i];
    printf("%lld\n", total);
    free(array);
} return 0; }
