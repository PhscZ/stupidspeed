// task 02 switch_case — expected output: 7500000075000000
// build: g++ -O2 -pthread -o prog 02_switch_case.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 02_switch_case.cpp | cl /O2 /EHsc /Fe:prog 02_switch_case.cpp

#include <cstdio>

int main() {
    long long acc = 0;

    for (long long i = 0; i < 100000000LL; ++i) {
        switch (i % 4) {
            case 0:
                acc += 1;
                break;
            case 1:
                acc += i;
                break;
            case 2:
                acc += 2 * i;
                break;
            case 3:
                acc += 3 * i;
                break;
        }
    }

    std::printf("%lld\n", acc);
    return 0;
}
