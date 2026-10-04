// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: gcc -O2 -pthread -o prog 01_branches.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 01_branches.c | cl /O2 /Fe:prog 01_branches.c | tcc -o prog 01_branches.c

#include <stdio.h>
#include <stdint.h>

#if defined(_WIN32)
#include <windows.h>
static double now_ms(void) {
    static LARGE_INTEGER freq;
    static int have_freq = 0;
    LARGE_INTEGER now;
    if (!have_freq) {
        QueryPerformanceFrequency(&freq);
        have_freq = 1;
    }
    QueryPerformanceCounter(&now);
    return (double)now.QuadPart * 1000.0 / (double)freq.QuadPart;
}
#else
#include <time.h>
static double now_ms(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec * 1000.0 + (double)ts.tv_nsec / 1000000.0;
}
#endif

int main(void) {
    double t0 = now_ms();
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

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld %lld %lld %lld\n", (long long)a, (long long)b, (long long)c, (long long)d);
    return 0;
}
