// task 09 fib_recursive — expected output: 102334155
// build: gcc -O2 -pthread -o prog 09_fib_recursive.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 09_fib_recursive.c | cl /O2 /Fe:prog 09_fib_recursive.c | tcc -o prog 09_fib_recursive.c

#include <stdio.h>
#include <stdint.h>

static int64_t fib(int64_t n) {
    if (n < 2) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

int main(void) {
    printf("%lld\n", (long long)fib(40));
    return 0;
}
