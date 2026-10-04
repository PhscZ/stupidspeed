// task 02 switch_case — expected output: 7500000075000000
// build: gcc -O2 -pthread -o prog 02_switch_case.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 02_switch_case.c | cl /O2 /Fe:prog 02_switch_case.c | tcc -o prog 02_switch_case.c

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
    int64_t acc = 0;

    for (int64_t i = 0; i < 100000000; i++) {
        switch (i % 4) {
            case 0: acc += 1; break;
            case 1: acc += i; break;
            case 2: acc += 2 * i; break;
            case 3: acc += 3 * i; break;
        }
    }

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)acc);
    return 0;
}
