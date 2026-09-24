// task 06 char_count — expected output: 10000000
// build: gcc -O2 -pthread -o prog main.c    run: ./prog
// alternates: clang -O2 -pthread -o prog main.c | cl /O2 /Fe:prog main.c | tcc -o prog main.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define BLOCK_LEN 10
#define REPEATS 10000000LL
#define TEXT_LEN (REPEATS * BLOCK_LEN)

int main(void) {
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

    printf("%lld\n", (long long)count);
    free(text);
    return 0;
}
