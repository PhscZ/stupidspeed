// task 02 switch_case — expected output: 7500000075000000
// build: gcc -O2 -pthread -o prog main.c    run: ./prog
// alternates: clang -O2 -pthread -o prog main.c | cl /O2 /Fe:prog main.c | tcc -o prog main.c

#include <stdio.h>
#include <stdint.h>

int main(void) {
    int64_t acc = 0;

    for (int64_t i = 0; i < 100000000; i++) {
        switch (i % 4) {
            case 0: acc += 1; break;
            case 1: acc += i; break;
            case 2: acc += 2 * i; break;
            case 3: acc += 3 * i; break;
        }
    }

    printf("%lld\n", (long long)acc);
    return 0;
}
