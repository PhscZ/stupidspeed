// task 05 alloc_churn — expected output: 1274991808
// build: g++ -O2 -pthread -o prog 05_alloc_churn.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 05_alloc_churn.cpp | cl /O2 /EHsc /Fe:prog 05_alloc_churn.cpp
// note: the slots store keeps each buffer reachable and releases the buffer it replaces
//       (the old one is deleted), so the 10000000 allocations cannot be optimized away.

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
    unsigned char* slots[256];
    for (int i = 0; i < 256; ++i) {
        slots[i] = nullptr;
    }

    long long total = 0;

    for (long long i = 0; i < 10000000LL; ++i) {
        unsigned char* buf = new unsigned char[64];
        buf[0] = static_cast<unsigned char>(i % 256);
        total += static_cast<long long>(buf[0]);

        unsigned char* old = slots[i % 256];
        slots[i % 256] = buf;
        delete[] old;
    }

    for (int i = 0; i < 256; ++i) {
        delete[] slots[i];
    }

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%lld\n", total);
    return 0;
}
