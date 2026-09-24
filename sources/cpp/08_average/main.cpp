// task 08 average — expected output: 0.498046875
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: every reading is a multiple of 1/256, so the sum is exact; the average is printed
//       with fixed notation and 9 digits after the point.

#include <iomanip>
#include <iostream>

int main() {
    double total = 0.0;

    for (long long i = 0; i < 100000000LL; ++i) {
        double reading = static_cast<double>(i % 256) / 256.0;
        total += reading;
    }

    std::cout << std::fixed << std::setprecision(9) << total / 100000000.0 << "\n";
    return 0;
}
