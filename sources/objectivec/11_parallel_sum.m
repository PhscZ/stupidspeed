// task 11 parallel_sum -- expected output: 7500000075000000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 11_parallel_sum.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
/* Benchmark task 11 equivalent: 4 real OS threads via Foundation NSThread.
   Expected: 7500000075000000 */
#import <Foundation/Foundation.h>

static long long gParts[4];

@interface Worker : NSObject
@property (nonatomic) int t;
@end

@implementation Worker
- (void)run:(id)ignored {
    long long acc = 0;
    long long lo = (long long)self.t * 25000000LL;
    long long hi = lo + 25000000LL;
    for (long long i = lo; i < hi; i++) {
        switch (i % 4) {
            case 0: acc = acc + 1;      break;
            case 1: acc = acc + i;      break;
            case 2: acc = acc + 2 * i;  break;
            case 3: acc = acc + 3 * i;  break;
        }
    }
    gParts[self.t] = acc;
}
@end

int main(void) {
    @autoreleasepool {
        NSMutableArray *threads = [NSMutableArray array];
        for (int t = 0; t < 4; t++) {
            Worker *w = [Worker new];
            w.t = t;
            NSThread *th = [[NSThread alloc] initWithTarget:w
                                                    selector:@selector(run:)
                                                      object:nil];
            [threads addObject:th];
            [th start];
        }
        for (NSThread *th in threads) {
            while (![th isFinished]) { [NSThread sleepForTimeInterval:0.001]; }
        }
        long long total = 0;
        for (int t = 0; t < 4; t++) total += gParts[t];
        printf("%lld\n", total);
    }
    return 0;
}
