// task 15 file_write — expected output: 104857600
// build: gcc -O2 -pthread -o prog main.c    run: ./prog
// alternates: clang -O2 -pthread -o prog main.c | cl /O2 /Fe:prog main.c | tcc -o prog main.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#if defined(_WIN32)
#include <io.h>
#else
#include <unistd.h>
#endif

#define CHUNK 1048576   /* 1 MiB */
#define REPEATS 100

int main(void) {
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

    printf("%lld\n", (long long)written);
    return 0;
}
