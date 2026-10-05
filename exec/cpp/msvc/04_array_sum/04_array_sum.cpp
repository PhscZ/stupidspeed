// task 04 array_sum — expected output: 499999500000
// build: g++ -O2 -pthread -o prog 04_array_sum.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 04_array_sum.cpp | cl /O2 /EHsc /Fe:prog 04_array_sum.cpp

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
    const long long n = 1000000LL;
    std::vector<long long> array(static_cast<size_t>(n));

    for (long long i = 0; i < n; ++i) {
        array[static_cast<size_t>(i)] = i;
    }

    long long total = 0;
    for (long long i = 0; i < n; ++i) {
        total = total + array[static_cast<size_t>(i)];
    }

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%lld\n", total);
    return 0;
}
