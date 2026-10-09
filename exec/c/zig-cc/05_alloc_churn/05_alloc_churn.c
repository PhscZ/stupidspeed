// task 05 alloc_churn — expected output: 1274991808
// build: gcc -O2 -pthread -o prog 05_alloc_churn.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 05_alloc_churn.c | cl /O2 /Fe:prog 05_alloc_churn.c | tcc -o prog 05_alloc_churn.c

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
    unsigned char *slots[256];
    for (int i = 0; i < 256; i++) {
        slots[i] = NULL;
    }

    int64_t total = 0;
    for (int64_t i = 0; i < 10000000; i++) {
        unsigned char *buf = (unsigned char *)malloc(64);
        buf[0] = (unsigned char)(i % 256);
        total += (int64_t)buf[0];

        int slot = (int)(i % 256);
        free(slots[slot]);   /* the buffer this slot replaces is released here */
        slots[slot] = buf;   /* keeping buf reachable stops -O2 deleting it */
    }

    for (int i = 0; i < 256; i++) {
        free(slots[i]);
    }

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)total);
    return 0;
}
