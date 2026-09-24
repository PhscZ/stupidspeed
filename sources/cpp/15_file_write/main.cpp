// task 15 file_write — expected output: 104857600
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: writes out.bin in 1 MiB chunks, flushes and fsyncs, then prints the byte count.

#include <cstdio>

#if defined(_WIN32)
#include <io.h>
#else
#include <unistd.h>
#endif

int main() {
    static unsigned char buffer[1024 * 1024];
    for (size_t i = 0; i < sizeof(buffer); ++i) {
        buffer[i] = static_cast<unsigned char>(i % 256);
    }

    std::FILE* file = std::fopen("out.bin", "wb");
    if (file == nullptr) {
        return 1;
    }

    unsigned long long written = 0;
    for (int pass = 0; pass < 100; ++pass) {
        written += static_cast<unsigned long long>(std::fwrite(buffer, 1, sizeof(buffer), file));
    }

    std::fflush(file);
#if defined(_WIN32)
    _commit(_fileno(file));
#else
    fsync(fileno(file));
#endif
    std::fclose(file);

    std::printf("%llu\n", written);
    return 0;
}
