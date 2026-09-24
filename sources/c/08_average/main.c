// task 08 average — expected output: 0.498046875
// build: gcc -O2 -pthread -o prog main.c    run: ./prog
// alternates: clang -O2 -pthread -o prog main.c | cl /O2 /Fe:prog main.c | tcc -o prog main.c

#include <stdio.h>
#include <stdint.h>

int main(void) {
    double total = 0.0;

    for (int64_t i = 0; i < 100000000; i++) {
        double reading = (double)(i % 256) / 256.0;
        total += reading;
    }

    printf("%.9f\n", total / 100000000.0);
    return 0;
}
