// task 07 string_append — expected output: 250000
// build: gcc -O2 -pthread -o prog 07_string_append.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 07_string_append.c | cl /O2 /Fe:prog 07_string_append.c | tcc -o prog 07_string_append.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

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
    size_t len = 0;
    char *text = (char *)malloc(1);
    text[0] = '\0';

    for (int64_t i = 0; i < 250000; i++) {
        len += 1;
        /* text = text + "x": room for one more character and the terminator,
           then strcat walks the whole string, so the loop is quadratic */
        text = (char *)realloc(text, len + 2);
        strcat(text, "x");
    }

    fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    printf("%lld\n", (long long)strlen(text));
    free(text);
    return 0;
}
