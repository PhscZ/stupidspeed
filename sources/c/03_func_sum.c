// task 03 func_sum — expected output: 100000000
// build: gcc -O2 -pthread -o prog 03_func_sum.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 03_func_sum.c | cl /O2 /Fe:prog 03_func_sum.c | tcc -o prog 03_func_sum.c

#include <stdio.h>
#include <stdint.h>

/* The call has to survive -O2, so the function is marked no-inline. */
#if defined(_MSC_VER)
__declspec(noinline)
#else
__attribute__((noinline))
#endif
static int64_t add_one(int64_t n) {
    return n + 1;
}

int main(void) {
    int64_t value = 0;

    for (int64_t i = 0; i < 100000000; i++) {
        value = add_one(value);
    }

    printf("%lld\n", (long long)value);
    return 0;
}
