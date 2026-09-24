// task 14 file_read — expected output: 484442112
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: reads data.bin from the working directory in 1 MiB chunks and prints the byte sum
//       reduced modulo 4294967296.

#include <cstdio>

int main() {
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

    std::printf("%llu\n", total % 4294967296ULL);
    return 0;
}
