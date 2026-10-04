// task 03 func_sum — expected output: 100000000
// build: gcc -O2 -pthread -o prog 03_func_sum.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 03_func_sum.c | cl /O2 /Fe:prog 03_func_sum.c | tcc -o prog 03_func_sum.c

#include <stdio.h>
#include <stdint.h>

/* The call has to survive -O2, so the function is marked no-inline. */
#if defined(_MSC_VER)
__declspec(noinline)
#else
__attribute__((noinline))
#endif
static int64_t add_one(int64_t n) {
    return n + 1;
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
    int64_t value = 0;

    for (int64_t i = 0; i < 100000000; i++) {
        value = add_one(value);
    }

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)value);
    return 0;
}
