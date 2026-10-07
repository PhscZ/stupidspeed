// task 07 string_append — expected output: 250000
// build: g++ -O2 -pthread -o prog 07_string_append.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 07_string_append.cpp | cl /O2 /EHsc /Fe:prog 07_string_append.cpp
// each iteration constructs a new string by copying the complete prior text.

#include <cstdio>
#include <string>

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
    std::string text;

    for (long long i = 0; i < 250000LL; ++i) {
        std::string next(text);
        next.push_back('x');
        text.swap(next);
    }

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%llu\n", static_cast<unsigned long long>(text.size()));
    return 0;
}
