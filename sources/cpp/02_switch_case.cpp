// task 02 switch_case — expected output: 7500000075000000
// build: g++ -O2 -pthread -o prog 02_switch_case.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 02_switch_case.cpp | cl /O2 /EHsc /Fe:prog 02_switch_case.cpp

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
    long long acc = 0;

    for (long long i = 0; i < 100000000LL; ++i) {
        switch (i % 4) {
            case 0:
                acc += 1;
                break;
            case 1:
                acc += i;
                break;
            case 2:
                acc += 2 * i;
                break;
            case 3:
                acc += 3 * i;
                break;
        }
    }

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%lld\n", acc);
    return 0;
}
