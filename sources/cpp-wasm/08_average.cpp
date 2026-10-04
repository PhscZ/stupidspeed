// task 08 average — expected output: 0.498046875
// build: g++ -O2 -pthread -o prog 08_average.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 08_average.cpp | cl /O2 /EHsc /Fe:prog 08_average.cpp
// note: every reading is a multiple of 1/256, so the sum is exact; the average is printed
//       with fixed notation and 9 digits after the point.

#include <iomanip>
#include <iostream>

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
    double total = 0.0;

    for (long long i = 0; i < 100000000LL; ++i) {
        double reading = static_cast<double>(i % 256) / 256.0;
        total += reading;
    }

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::cout << std::fixed << std::setprecision(9) << total / 100000000.0 << "\n";
    return 0;
}
