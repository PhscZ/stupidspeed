// task 09 fib_recursive — expected output: 102334155
// build: gcc -O2 -pthread -o prog 09_fib_recursive.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 09_fib_recursive.c | cl /O2 /Fe:prog 09_fib_recursive.c | tcc -o prog 09_fib_recursive.c

#include <stdio.h>
#include <stdint.h>

static int64_t fib(int64_t n) {
    if (n < 2) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

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
    int64_t result = fib(40);
    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)result);
    return 0;
}
