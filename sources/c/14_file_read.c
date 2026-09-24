// task 14 file_read — expected output: 484442112
// build: gcc -O2 -pthread -o prog 14_file_read.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 14_file_read.c | cl /O2 /Fe:prog 14_file_read.c | tcc -o prog 14_file_read.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define CHUNK 1048576   /* 1 MiB */

int main(void) {
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

    printf("%llu\n", (unsigned long long)(total % 4294967296ULL));
    return 0;
}
