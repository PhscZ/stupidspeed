// task 15 file_write — expected output: 52428800
// build: g++ -O2 -pthread -o prog 15_file_write.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 15_file_write.cpp | cl /O2 /EHsc /Fe:prog 15_file_write.cpp
// note: writes out.bin in 1 MiB chunks, flushes and fsyncs, then prints the byte count.

#include <cstdio>

#if defined(_WIN32)
#include <io.h>
#else
#include <unistd.h>
#endif

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
    for (size_t i = 0; i < sizeof(buffer); ++i) {
        buffer[i] = static_cast<unsigned char>(i % 256);
    }

    std::FILE* file = std::fopen("out.bin", "wb");
    if (file == nullptr) {
        return 1;
    }

    unsigned long long written = 0;
    for (int pass = 0; pass < 50; ++pass) {
        written += static_cast<unsigned long long>(std::fwrite(buffer, 1, sizeof(buffer), file));
    }

    std::fflush(file);
#if defined(_WIN32)
    _commit(_fileno(file));
#else
    fsync(fileno(file));
#endif
    std::fclose(file);

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%llu\n", written);
    return 0;
}
