// task 06 char_count — expected output: 10000000
// build: g++ -O2 -pthread -o prog 06_char_count.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 06_char_count.cpp | cl /O2 /EHsc /Fe:prog 06_char_count.cpp
// note: the 100000000-character text is built once by repeating the 10-character block
//       (reserve + memcpy), then scanned one character at a time with an index loop.

#include <cstdio>
#include <cstring>
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
    const size_t blockLength = 10;
    const size_t blockRepeats = 10000000;
    const size_t textLength = blockLength * blockRepeats;
    const char block[10] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};

    std::string text;
    text.reserve(textLength);
    text.resize(textLength);
    char* out = &text[0];
    for (size_t i = 0; i < blockRepeats; ++i) {
        std::memcpy(out + i * blockLength, block, blockLength);
    }

    long long count = 0;
    for (size_t i = 0; i < text.size(); ++i) {
        if (text[i] == 'a') {
            // skip
        } else if (text[i] == 'e') {
            // skip
        } else if (text[i] == 'h') {
            count += 1;
        } else {
            // skip
        }
    }

    std::fprintf(stderr, "TIME_MS=%.3f\n", now_ms() - t0);
    std::printf("%lld\n", count);
    return 0;
}
