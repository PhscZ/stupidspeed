// task 10 pi -- expected output: 44889
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 10_pi.m -lobjc -lgnustep-base    run: ./prog
// Objective-C has no big integers in its standard library; task 10 hand-rolls base-1e9 limbs.
/* Benchmark task 10 equivalent, idiomatic Objective-C: 10000 digits of pi via
   Gibbons' unbounded spigot, with the arbitrary-precision state in a hand-rolled
   BigInt class (ObjC has no bignum in its standard library, exactly like C).
   Expected output: 44889 */
#import <Foundation/Foundation.h>

#define BASE 1000000000ULL

@interface BigInt : NSObject {
@public
    uint64_t *limb;   /* little-endian, base 1e9 */
    size_t n;         /* limb count, no leading zero limbs */
    size_t cap;
    int neg;
}
- (instancetype)init;
- (void)dealloc;
- (void)reserve:(size_t)need;
- (void)trim;
- (void)setU64:(uint64_t)v;
- (void)copyFrom:(BigInt *)src;
- (int)cmpMag:(BigInt *)b;
- (int)cmp:(BigInt *)b;
- (void)addMag:(BigInt *)a with:(BigInt *)b;
- (void)subMag:(BigInt *)a with:(BigInt *)b;
- (void)add:(BigInt *)a with:(BigInt *)b;
- (void)sub:(BigInt *)a with:(BigInt *)b;
- (void)mulSmall:(BigInt *)a by:(uint64_t)m;
- (uint64_t)quot:(BigInt *)a by:(BigInt *)b work:(BigInt *)work;
@end

@implementation BigInt

- (instancetype)init {
    self = [super init];
    if (self) {
        n = 0; neg = 0; cap = 8;
        limb = (uint64_t *)malloc(cap * sizeof(uint64_t));
    }
    return self;
}

- (void)dealloc {
    free(limb);
}

- (void)reserve:(size_t)need {
    if (need <= cap) return;
    while (cap < need) cap *= 2;
    limb = (uint64_t *)realloc(limb, cap * sizeof(uint64_t));
}

- (void)trim {
    while (n > 0 && limb[n - 1] == 0) n--;
    if (n == 0) neg = 0;
}

- (void)setU64:(uint64_t)v {
    n = 0; neg = 0;
    while (v > 0) {
        [self reserve:n + 1];
        limb[n++] = v % BASE;
        v /= BASE;
    }
}

- (void)copyFrom:(BigInt *)src {
    [self reserve:src->n];
    if (src->n > 0) memcpy(limb, src->limb, src->n * sizeof(uint64_t));
    n = src->n;
    neg = src->neg;
}

- (int)cmpMag:(BigInt *)b {
    if (n != b->n) return n < b->n ? -1 : 1;
    for (size_t i = n; i-- > 0; ) {
        if (limb[i] != b->limb[i]) return limb[i] < b->limb[i] ? -1 : 1;
    }
    return 0;
}

- (int)cmp:(BigInt *)b {
    if (neg != b->neg) return neg ? -1 : 1;
    int c = [self cmpMag:b];
    return neg ? -c : c;
}

- (void)addMag:(BigInt *)a with:(BigInt *)b {
    size_t nn = a->n > b->n ? a->n : b->n;
    [self reserve:nn + 1];
    uint64_t carry = 0;
    for (size_t i = 0; i < nn; i++) {
        uint64_t s = carry;
        if (i < a->n) s += a->limb[i];
        if (i < b->n) s += b->limb[i];
        if (s >= BASE) { s -= BASE; carry = 1; } else { carry = 0; }
        limb[i] = s;
    }
    limb[nn] = carry;
    n = nn + (carry ? 1 : 0);
    neg = 0;
}

- (void)subMag:(BigInt *)a with:(BigInt *)b {   /* requires a >= b >= 0 */
    [self reserve:a->n];
    uint64_t borrow = 0;
    for (size_t i = 0; i < a->n; i++) {
        uint64_t bi = (i < b->n ? b->limb[i] : 0) + borrow;
        if (a->limb[i] >= bi) { limb[i] = a->limb[i] - bi; borrow = 0; }
        else { limb[i] = a->limb[i] + BASE - bi; borrow = 1; }
    }
    n = a->n;
    neg = 0;
    [self trim];
}

- (void)add:(BigInt *)a with:(BigInt *)b {
    int an = a->neg, bn = b->neg;
    if (an == bn) {
        [self addMag:a with:b];
        neg = an;
    } else if ([a cmpMag:b] >= 0) {
        [self subMag:a with:b];
        neg = an;
    } else {
        [self subMag:b with:a];
        neg = bn;
    }
    [self trim];
}

- (void)sub:(BigInt *)a with:(BigInt *)b {       /* self = a - b */
    int an = a->neg, bn = b->neg;
    if (an != bn) {
        [self addMag:a with:b];
        neg = an;
    } else if ([a cmpMag:b] >= 0) {
        [self subMag:a with:b];
        neg = an;
    } else {
        [self subMag:b with:a];
        neg = !an;
    }
    [self trim];
}

- (void)mulSmall:(BigInt *)a by:(uint64_t)m {
    if (m == 0 || a->n == 0) { n = 0; neg = 0; return; }
    [self reserve:a->n + 2];
    uint64_t carry = 0;
    for (size_t i = 0; i < a->n; i++) {
        uint64_t p = a->limb[i] * m + carry;
        limb[i] = p % BASE;
        carry = p / BASE;
    }
    size_t nn = a->n;
    while (carry > 0) { limb[nn++] = carry % BASE; carry /= BASE; }
    n = nn;
    neg = a->neg;
    [self trim];
}

/* floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of
   one decimal digit, so counting how many times b fits into a is enough. */
- (uint64_t)quot:(BigInt *)a by:(BigInt *)b work:(BigInt *)work {
    uint64_t q = 0;
    if (a->neg || b->neg || b->n == 0) return 0;
    [work copyFrom:b];
    while ([a cmp:work] >= 0) {
        q++;
        [work addMag:work with:b];
    }
    return q;
}

@end

int main(void) {
    @autoreleasepool {
        BigInt *q = [BigInt new];
        BigInt *r = [BigInt new];
        BigInt *t = [BigInt new];
        BigInt *u = [BigInt new];
        BigInt *v = [BigInt new];
        BigInt *w = [BigInt new];

        [q setU64:1];
        [r setU64:0];
        [t setU64:1];

        uint64_t k = 1, l = 3, n = 3;
        uint64_t sum = 0;

        for (long long produced = 0; produced < 10000; ) {
            [u mulSmall:q by:4];
            [u add:u with:r];                 /* u = 4q + r */
            [v mulSmall:t by:n + 1];          /* v = (n + 1)t */

            if ([u cmp:v] < 0) {
                sum += n;
                produced++;

                [u mulSmall:q by:3];
                [u add:u with:r];
                [u mulSmall:u by:10];         /* u = 10(3q + r) */
                uint64_t next = [u quot:u by:t work:w] - 10 * n;

                [v mulSmall:t by:n];          /* v = n t */
                [v sub:r with:v];             /* v = r - n t */
                [r mulSmall:v by:10];         /* r = 10(r - n t) */
                [q mulSmall:q by:10];         /* q = 10q */

                n = next;
            } else {
                [u mulSmall:q by:7 * k + 2];
                [v mulSmall:r by:l];
                [u add:u with:v];             /* u = q(7k + 2) + r l */
                [v mulSmall:t by:l];          /* v = t l */
                uint64_t next = [u quot:u by:v work:w];

                [u mulSmall:q by:2];
                [u add:u with:r];
                [u mulSmall:u by:l];          /* u = (2q + r) l */
                [r copyFrom:u];
                [q mulSmall:q by:k];
                [t mulSmall:t by:l];

                k++;
                l += 2;
                n = next;
            }
        }

        printf("%llu\n", (unsigned long long)sum);
    }
    return 0;
}
