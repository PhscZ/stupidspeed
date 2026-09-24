// task 06 char_count — expected output: 10000000
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: the 100000000-character text is built once by repeating the 10-character block
//       (reserve + memcpy), then scanned one character at a time with an index loop.

#include <cstdio>
#include <cstring>
#include <string>

int main() {
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

    std::printf("%lld\n", count);
    return 0;
}
