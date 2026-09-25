// task 14 file_read -- expected output: 484442112
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 14_file_read.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:@"data.bin"];
    unsigned long long total = 0;
    NSData *blk;
    while ((blk = [fh readDataOfLength:1048576]).length > 0) {
        const unsigned char *p = blk.bytes;
        NSUInteger len = blk.length;
        for (NSUInteger i = 0; i < len; i++) total = total + p[i];
    }
    [fh closeFile];
    printf("%llu\n", total % 4294967296ULL);
} return 0; }
