// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: g++ -O2 -pthread -o prog 01_branches.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 01_branches.cpp | cl /O2 /EHsc /Fe:prog 01_branches.cpp

#include <cstdio>

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

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%lld %lld %lld %lld\n", a, b, c, d);
    return 0;
}
