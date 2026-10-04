// task 04 array_sum — expected output: 499999500000
// build: gcc -O2 -pthread -o prog 04_array_sum.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 04_array_sum.c | cl /O2 /Fe:prog 04_array_sum.c | tcc -o prog 04_array_sum.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

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
    const int64_t n = 1000000;
    int64_t *array = (int64_t *)malloc((size_t)n * sizeof(int64_t));

    for (int64_t i = 0; i < n; i++) {
        array[i] = i;
    }

    int64_t total = 0;
    for (int64_t i = 0; i < n; i++) {
        total += array[i];
    }

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)total);
    free(array);
    return 0;
}
