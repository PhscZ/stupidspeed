// task 08 average -- expected output: 0.498046875
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 08_average.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    double total = 0.0;
    for (long long i = 0; i < 100000000LL; i++) {
        double reading = (double)(i % 256) / 256.0;
        total = total + reading;
    }
    printf("%.9f\n", total / 100000000.0);
} return 0; }
