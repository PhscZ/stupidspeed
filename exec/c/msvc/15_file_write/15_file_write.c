// task 15 file_write — expected output: 52428800
// build: gcc -O2 -pthread -o prog 15_file_write.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 15_file_write.c | cl /O2 /Fe:prog 15_file_write.c | tcc -o prog 15_file_write.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#if defined(_WIN32)
#include <io.h>
#else
#include <unistd.h>
#endif

#define CHUNK 1048576   /* 1 MiB */
#define REPEATS 50

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
    unsigned char *buf = (unsigned char *)malloc(CHUNK);
    for (int i = 0; i < CHUNK; i++) {
        buf[i] = (unsigned char)(i % 256);
    }

    FILE *f = fopen("out.bin", "wb");
    if (f == NULL) {
        free(buf);
        return 1;
    }

    int64_t written = 0;
    for (int i = 0; i < REPEATS; i++) {
        written += (int64_t)fwrite(buf, 1, CHUNK, f);
    }

    fflush(f);
#if defined(_WIN32)
    _commit(_fileno(f));
#else
    fsync(fileno(f));
#endif
    fclose(f);
    free(buf);

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)written);
    return 0;
}
