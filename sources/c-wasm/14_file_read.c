// task 14 file_read — expected output: 2389704704
// build: gcc -O2 -pthread -o prog 14_file_read.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 14_file_read.c | cl /O2 /Fe:prog 14_file_read.c | tcc -o prog 14_file_read.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define CHUNK 1048576   /* 1 MiB */

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
    FILE *f = fopen("data.bin", "rb");
    if (f == NULL) {
        return 1;
    }

    unsigned char *buf = (unsigned char *)malloc(CHUNK);
    uint64_t total = 0;
    size_t got;

    while ((got = fread(buf, 1, CHUNK, f)) > 0) {
        for (size_t i = 0; i < got; i++) {
            total += (uint64_t)buf[i];
        }
    }

    fclose(f);
    free(buf);

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%llu\n", (unsigned long long)(total % 4294967296ULL));
    return 0;
}
