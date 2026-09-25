// task 07 string_append -- expected output: 1000000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 07_string_append.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    NSMutableString *text = [NSMutableString stringWithCapacity:1000000];
    for (int i = 0; i < 1000000; i++) [text appendString:@"x"];
    printf("%lu\n", (unsigned long)[text length]);
} return 0; }
