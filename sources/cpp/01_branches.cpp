// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: g++ -O2 -pthread -o prog 01_branches.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 01_branches.cpp | cl /O2 /EHsc /Fe:prog 01_branches.cpp

#include <cstdio>

int main() {
    long long a = 0;
    long long b = 0;
    long long c = 0;
    long long d = 0;

    for (long long i = 0; i < 100000000LL; ++i) {
        if (i % 3 == 0) {
            a += 1;
        } else if (i % 5 == 0) {
            b += 1;
        } else if (i % 7 == 0) {
            c += 1;
        } else {
            d += 1;
        }
    }

    std::printf("%lld %lld %lld %lld\n", a, b, c, d);
    return 0;
}
