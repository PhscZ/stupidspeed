// task 13 matrix_mul — expected output: 599995000
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: plain i,j,k triple loop over flat n*n arrays, no loop reordering.

#include <cstdio>
#include <vector>

int main() {
    const int n = 500;
    const size_t size = static_cast<size_t>(n) * static_cast<size_t>(n);

    std::vector<long long> a(size);
    std::vector<long long> b(size);
    std::vector<long long> c(size, 0);

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            const size_t idx = static_cast<size_t>(i) * static_cast<size_t>(n) + static_cast<size_t>(j);
            a[idx] = (i + j) % 7;
            b[idx] = (static_cast<long long>(i) * static_cast<long long>(j)) % 5;
        }
    }

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            long long sum = 0;
            for (int k = 0; k < n; ++k) {
                sum += a[static_cast<size_t>(i) * static_cast<size_t>(n) + static_cast<size_t>(k)] *
                       b[static_cast<size_t>(k) * static_cast<size_t>(n) + static_cast<size_t>(j)];
            }
            c[static_cast<size_t>(i) * static_cast<size_t>(n) + static_cast<size_t>(j)] = sum;
        }
    }

    long long total = 0;
    for (size_t idx = 0; idx < size; ++idx) {
        total += c[idx];
    }

    std::printf("%lld\n", total);
    return 0;
}
