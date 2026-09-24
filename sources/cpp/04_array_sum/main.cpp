// task 04 array_sum — expected output: 499999500000
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp

#include <cstdio>
#include <vector>

int main() {
    const long long n = 1000000LL;
    std::vector<long long> array(static_cast<size_t>(n));

    for (long long i = 0; i < n; ++i) {
        array[static_cast<size_t>(i)] = i;
    }

    long long total = 0;
    for (long long i = 0; i < n; ++i) {
        total = total + array[static_cast<size_t>(i)];
    }

    std::printf("%lld\n", total);
    return 0;
}
