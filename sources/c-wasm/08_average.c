// task 08 average — expected output: 0.498046875
// build: gcc -O2 -pthread -o prog 08_average.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 08_average.c | cl /O2 /Fe:prog 08_average.c | tcc -o prog 08_average.c

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
    double total = 0.0;

    for (int64_t i = 0; i < 100000000; i++) {
        double reading = (double)(i % 256) / 256.0;
        total += reading;
    }

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%.9f\n", total / 100000000.0);
    return 0;
}
