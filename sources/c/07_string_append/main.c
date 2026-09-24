// task 07 string_append — expected output: 1000000
// build: gcc -O2 -pthread -o prog main.c    run: ./prog
// alternates: clang -O2 -pthread -o prog main.c | cl /O2 /Fe:prog main.c | tcc -o prog main.c

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    size_t len = 0;
    char *text = (char *)malloc(1);
    text[0] = '\0';

    for (int64_t i = 0; i < 1000000; i++) {
        len += 1;
        /* text = text + "x": room for one more character and the terminator,
           then strcat walks the whole string, so the loop is quadratic */
        text = (char *)realloc(text, len + 2);
        strcat(text, "x");
    }

    printf("%lld\n", (long long)strlen(text));
    free(text);
    return 0;
}
