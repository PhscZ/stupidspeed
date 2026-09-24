// task 05 alloc_churn — expected output: 1274991808
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: the slots store keeps each buffer reachable and releases the buffer it replaces
//       (the old one is deleted), so the 10000000 allocations cannot be optimized away.

#include <cstdio>

int main() {
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

    std::printf("%lld\n", total);
    return 0;
}
