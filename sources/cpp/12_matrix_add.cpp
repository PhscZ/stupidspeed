// task 12 matrix_add — expected output: 999000000
// build: g++ -O2 -pthread -o prog 12_matrix_add.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 12_matrix_add.cpp | cl /O2 /EHsc /Fe:prog 12_matrix_add.cpp
// note: flat n*n arrays with index i*n+j.

#include <cstdio>
#include <vector>

#if defined(_WIN32)
#include <windows.h>
static double now_ms() {
    static LARGE_INTEGER freq;
    static bool have_freq = false;
    LARGE_INTEGER now;
    if (!have_freq) {
        QueryPerformanceFrequency(&freq);
        have_freq = true;
    }
    QueryPerformanceCounter(&now);
    return static_cast<double>(now.QuadPart) * 1000.0 / static_cast<double>(freq.QuadPart);
}
#else
#include <time.h>
static double now_ms() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return static_cast<double>(ts.tv_sec) * 1000.0 + static_cast<double>(ts.tv_nsec) / 1000000.0;
}
#endif
#include <cstdio>

int main() {
    double t0 = now_ms();
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

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%lld\n", total);
    return 0;
}
