// task 07 string_append — expected output: 1000000
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: plain std::string concatenation, which may copy the whole string every time.

#include <cstdio>
#include <string>

int main() {
    std::string text;

    for (long long i = 0; i < 1000000LL; ++i) {
        text += "x";
    }

    std::printf("%llu\n", static_cast<unsigned long long>(text.size()));
    return 0;
}
