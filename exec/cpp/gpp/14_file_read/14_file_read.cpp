// task 14 file_read — expected output: 2389704704
// build: g++ -O2 -pthread -o prog 14_file_read.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 14_file_read.cpp | cl /O2 /EHsc /Fe:prog 14_file_read.cpp
// note: reads data.bin from the working directory in 1 MiB chunks and prints the byte sum
//       reduced modulo 4294967296.

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
    static unsigned char buffer[1024 * 1024];

    std::FILE* file = std::fopen("data.bin", "rb");
    if (file == nullptr) {
        return 1;
    }

    unsigned long long total = 0;
    size_t got = 0;
    while ((got = std::fread(buffer, 1, sizeof(buffer), file)) > 0) {
        for (size_t i = 0; i < got; ++i) {
            total += static_cast<unsigned long long>(buffer[i]);
        }
    }

    std::fclose(file);

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%llu\n", total % 4294967296ULL);
    return 0;
}
