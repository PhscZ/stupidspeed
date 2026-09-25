// task 15 file_write -- expected output: 104857600
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 15_file_write.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
#import <Foundation/Foundation.h>
int main(void) { @autoreleasepool {
    unsigned char *chunk = malloc(1048576);
    for (int i = 0; i < 1048576; i++) chunk[i] = (unsigned char)(i % 256);
    NSData *buffer = [NSData dataWithBytes:chunk length:1048576];
    [[NSFileManager defaultManager] createFileAtPath:@"out.bin" contents:nil attributes:nil];
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:@"out.bin"];
    for (int i = 0; i < 100; i++) [fh writeData:buffer];
    [fh synchronizeFile];
    [fh closeFile];
    unsigned long long written =
        [[[NSFileManager defaultManager] attributesOfItemAtPath:@"out.bin" error:NULL] fileSize];
    printf("%llu\n", written);
} return 0; }
