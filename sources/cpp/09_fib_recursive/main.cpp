// task 09 fib_recursive — expected output: 102334155
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: naive double recursion, no memoization.

#include <cstdio>

static long long fib(long long n) {
    if (n < 2) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

int main() {
    std::printf("%lld\n", fib(40));
    return 0;
}
