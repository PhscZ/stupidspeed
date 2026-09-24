// task 10 pi — expected output: 44889
// build: gcc -O2 -pthread -o prog 10_pi.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 10_pi.c | cl /O2 /Fe:prog 10_pi.c | tcc -o prog 10_pi.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

/* Gibbons' unbounded spigot runs on arbitrary-precision integers, which C has no
   library for, so the state is kept in hand-written big integers: sign-magnitude,
   little-endian 64-bit limbs, base 1e9. Only the operations the spigot needs are
   here: add, subtract, multiply by a small int (limb * small + carry fits in 64
   bits for small < 2^32), and a quotient, which is always one decimal digit and so
   comes out of repeated subtraction. No 128-bit arithmetic is used, so tcc and
   MSVC build it too. The digits themselves are never printed, only their sum. */

#define BASE 1000000000ULL

typedef struct {
    uint64_t *limb;   /* little-endian, base 1e9 */
    size_t n;         /* limb count, no leading zero limbs */
    size_t cap;
    int neg;
} Big;

static void big_init(Big *x) {
    x->n = 0;
    x->cap = 8;
    x->neg = 0;
    x->limb = (uint64_t *)malloc(x->cap * sizeof(uint64_t));
}

static void big_free(Big *x) {
    free(x->limb);
    x->limb = NULL;
}

static void big_reserve(Big *x, size_t need) {
    if (need <= x->cap) {
        return;
    }
    while (x->cap < need) {
        x->cap *= 2;
    }
    x->limb = (uint64_t *)realloc(x->limb, x->cap * sizeof(uint64_t));
}

static void big_trim(Big *x) {
    while (x->n > 0 && x->limb[x->n - 1] == 0) {
        x->n--;
    }
    if (x->n == 0) {
        x->neg = 0;
    }
}

static void big_set(Big *x, uint64_t v) {
    x->n = 0;
    x->neg = 0;
    while (v > 0) {
        big_reserve(x, x->n + 1);
        x->limb[x->n++] = v % BASE;
        v /= BASE;
    }
}

static void big_copy(Big *dst, const Big *src) {
    big_reserve(dst, src->n);
    if (src->n > 0) {
        memcpy(dst->limb, src->limb, src->n * sizeof(uint64_t));
    }
    dst->n = src->n;
    dst->neg = src->neg;
}

static int big_cmp_mag(const Big *a, const Big *b) {
    if (a->n != b->n) {
        return a->n < b->n ? -1 : 1;
    }
    for (size_t i = a->n; i-- > 0; ) {
        if (a->limb[i] != b->limb[i]) {
            return a->limb[i] < b->limb[i] ? -1 : 1;
        }
    }
    return 0;
}

static int big_cmp(const Big *a, const Big *b) {
    if (a->neg != b->neg) {
        return a->neg ? -1 : 1;
    }
    int c = big_cmp_mag(a, b);
    return a->neg ? -c : c;
}

static void big_add_mag(Big *r, const Big *a, const Big *b) {
    size_t n = a->n > b->n ? a->n : b->n;
    big_reserve(r, n + 1);
    uint64_t carry = 0;
    for (size_t i = 0; i < n; i++) {
        uint64_t s = carry;
        if (i < a->n) {
            s += a->limb[i];
        }
        if (i < b->n) {
            s += b->limb[i];
        }
        if (s >= BASE) {
            s -= BASE;
            carry = 1;
        } else {
            carry = 0;
        }
        r->limb[i] = s;
    }
    r->limb[n] = carry;
    r->n = n + (carry ? 1 : 0);
    r->neg = 0;
}

static void big_sub_mag(Big *r, const Big *a, const Big *b) {   /* requires a >= b >= 0 */
    big_reserve(r, a->n);
    uint64_t borrow = 0;
    for (size_t i = 0; i < a->n; i++) {
        uint64_t bi = (i < b->n ? b->limb[i] : 0) + borrow;
        if (a->limb[i] >= bi) {
            r->limb[i] = a->limb[i] - bi;
            borrow = 0;
        } else {
            r->limb[i] = a->limb[i] + BASE - bi;
            borrow = 1;
        }
    }
    r->n = a->n;
    r->neg = 0;
    big_trim(r);
}

static void big_add(Big *r, const Big *a, const Big *b) {
    int an = a->neg, bn = b->neg;
    if (an == bn) {
        big_add_mag(r, a, b);
        r->neg = an;
    } else if (big_cmp_mag(a, b) >= 0) {
        big_sub_mag(r, a, b);
        r->neg = an;
    } else {
        big_sub_mag(r, b, a);
        r->neg = bn;
    }
    big_trim(r);
}

static void big_sub(Big *r, const Big *a, const Big *b) {       /* r = a - b */
    int an = a->neg, bn = b->neg;
    if (an != bn) {
        big_add_mag(r, a, b);
        r->neg = an;
    } else if (big_cmp_mag(a, b) >= 0) {
        big_sub_mag(r, a, b);
        r->neg = an;
    } else {
        big_sub_mag(r, b, a);
        r->neg = !an;
    }
    big_trim(r);
}

static void big_mul_small(Big *r, const Big *a, uint64_t m) {
    if (m == 0 || a->n == 0) {
        r->n = 0;
        r->neg = 0;
        return;
    }
    big_reserve(r, a->n + 2);
    uint64_t carry = 0;
    for (size_t i = 0; i < a->n; i++) {
        uint64_t p = a->limb[i] * m + carry;
        r->limb[i] = p % BASE;
        carry = p / BASE;
    }
    size_t n = a->n;
    while (carry > 0) {
        r->limb[n++] = carry % BASE;
        carry /= BASE;
    }
    r->n = n;
    r->neg = a->neg;
    big_trim(r);
}

/* floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of
   one decimal digit, so counting how many times b fits into a is enough. */
static uint64_t big_quot(const Big *a, const Big *b, Big *work) {
    uint64_t q = 0;
    if (a->neg || b->neg || b->n == 0) {
        return 0;
    }
    big_copy(work, b);
    while (big_cmp(a, work) >= 0) {
        q++;
        big_add_mag(work, work, b);
    }
    return q;
}

int main(void) {
    Big q, r, t, u, v, w;
    big_init(&q);
    big_init(&r);
    big_init(&t);
    big_init(&u);
    big_init(&v);
    big_init(&w);

    big_set(&q, 1);
    big_set(&r, 0);
    big_set(&t, 1);

    uint64_t k = 1, l = 3, n = 3;
    uint64_t sum = 0;

    for (int64_t produced = 0; produced < 10000; ) {
        big_mul_small(&u, &q, 4);
        big_add(&u, &u, &r);             /* u = 4q + r */
        big_mul_small(&v, &t, n + 1);    /* v = (n + 1)t */

        if (big_cmp(&u, &v) < 0) {
            /* the digit n is settled */
            sum += n;
            produced++;

            big_mul_small(&u, &q, 3);
            big_add(&u, &u, &r);
            big_mul_small(&u, &u, 10);           /* u = 10(3q + r) */
            uint64_t next = big_quot(&u, &t, &w) - 10 * n;

            big_mul_small(&v, &t, n);            /* v = n t */
            big_sub(&v, &r, &v);                 /* v = r - n t */
            big_mul_small(&r, &v, 10);           /* r = 10(r - n t) */
            big_mul_small(&q, &q, 10);           /* q = 10q, t is unchanged */

            n = next;
        } else {
            /* not settled yet: widen the state by one more term */
            big_mul_small(&u, &q, 7 * k + 2);
            big_mul_small(&v, &r, l);
            big_add(&u, &u, &v);                 /* u = q(7k + 2) + r l */
            big_mul_small(&v, &t, l);            /* v = t l */
            uint64_t next = big_quot(&u, &v, &w);

            big_mul_small(&u, &q, 2);
            big_add(&u, &u, &r);
            big_mul_small(&u, &u, l);            /* u = (2q + r) l */
            big_copy(&r, &u);
            big_mul_small(&q, &q, k);
            big_mul_small(&t, &t, l);

            k++;
            l += 2;
            n = next;
        }
    }

    printf("%llu\n", (unsigned long long)sum);

    big_free(&q);
    big_free(&r);
    big_free(&t);
    big_free(&u);
    big_free(&v);
    big_free(&w);
    return 0;
}
