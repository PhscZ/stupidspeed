// task 07 string_append — expected output: 1000000
// build: g++ -O2 -pthread -o prog 07_string_append.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 07_string_append.cpp | cl /O2 /EHsc /Fe:prog 07_string_append.cpp
// each iteration constructs a new string by copying the complete prior text.

#include <cstdio>
#include <string>

int main() {
    std::string text;

    for (long long i = 0; i < 1000000LL; ++i) {
        std::string next(text);
        next.push_back('x');
        text.swap(next);
    }

    std::printf("%llu\n", static_cast<unsigned long long>(text.size()));
    return 0;
}
