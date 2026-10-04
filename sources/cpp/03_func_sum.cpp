// task 03 func_sum — expected output: 100000000
// build: g++ -O2 -pthread -o prog 03_func_sum.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 03_func_sum.cpp | cl /O2 /EHsc /Fe:prog 03_func_sum.cpp
// note: the call is kept by an explicit no-inline attribute (__declspec(noinline) under MSVC,
//       [[gnu::noinline]] under g++/clang++), so add_one is really called 100000000 times.

#include <cstdio>

#if defined(_MSC_VER)
__declspec(noinline)
#else
[[gnu::noinline]]
#endif
static long long add_one(long long n) {
    return n + 1;
}

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
    long long value = 0;

    for (long long i = 0; i < 100000000LL; ++i) {
        value = add_one(value);
    }

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%lld\n", value);
    return 0;
}
