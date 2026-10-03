// task 12 matrix_add — expected output: 999000000
// build: g++ -O2 -pthread -o prog 12_matrix_add.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 12_matrix_add.cpp | cl /O2 /EHsc /Fe:prog 12_matrix_add.cpp
// note: flat n*n arrays with index i*n+j.

#include <cstdio>
#include <vector>

int main() {
    const int n = 1000;
    const size_t size = static_cast<size_t>(n) * static_cast<size_t>(n);

    std::vector<long long> a(size);
    std::vector<long long> b(size);
    std::vector<long long> c(size);

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            const size_t idx = static_cast<size_t>(i) * static_cast<size_t>(n) + static_cast<size_t>(j);
            a[idx] = i + j;
            b[idx] = i - j;
        }
    }

    for (size_t idx = 0; idx < size; ++idx) {
        c[idx] = a[idx] + b[idx];
    }

    long long total = 0;
    for (size_t idx = 0; idx < size; ++idx) {
        total += c[idx];
    }

    std::printf("%lld\n", total);
    return 0;
}
