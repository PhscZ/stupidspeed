// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: gcc -O2 -pthread -o prog main.c    run: ./prog
// alternates: clang -O2 -pthread -o prog main.c | cl /O2 /Fe:prog main.c | tcc -o prog main.c

#include <stdio.h>
#include <stdint.h>

int main(void) {
    int64_t a = 0, b = 0, c = 0, d = 0;

    for (int64_t i = 0; i < 100000000; i++) {
        if (i % 3 == 0) {
            a += 1;
        } else if (i % 5 == 0) {
            b += 1;
        } else if (i % 7 == 0) {
            c += 1;
        } else {
            d += 1;
        }
    }

    printf("%lld %lld %lld %lld\n", (long long)a, (long long)b, (long long)c, (long long)d);
    return 0;
}
