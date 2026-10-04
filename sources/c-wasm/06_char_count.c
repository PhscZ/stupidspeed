// task 06 char_count — expected output: 10000000
// build: gcc -O2 -pthread -o prog 06_char_count.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 06_char_count.c | cl /O2 /Fe:prog 06_char_count.c | tcc -o prog 06_char_count.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define BLOCK_LEN 10
#define REPEATS 10000000LL
#define TEXT_LEN (REPEATS * BLOCK_LEN)

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
    char *text = (char *)malloc((size_t)TEXT_LEN);

    /* the whole 100 MB text is built up front, block by block */
    for (int64_t i = 0; i < REPEATS; i++) {
        memcpy(text + i * BLOCK_LEN, "abcdefghij", BLOCK_LEN);
    }

    int64_t count = 0;
    for (int64_t i = 0; i < TEXT_LEN; i++) {
        if (text[i] == 'h') {
            count += 1;
        }
    }

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)count);
    free(text);
    return 0;
}
