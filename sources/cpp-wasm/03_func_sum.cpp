// task 03 func_sum — expected output: 100000000
// build: g++ -O2 -pthread -o prog 03_func_sum.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 03_func_sum.cpp | cl /O2 /EHsc /Fe:prog 03_func_sum.cpp
// note: the call is kept by an explicit no-inline attribute (__declspec(noinline) under MSVC,
//       [[gnu::noinline]] under g++/clang++), so add_one is really called 100000000 times.

#include <cstdio>

#if defined(_MSC_VER)
__declspec(noinline)
#else
[[gnu::noinline]]
#endif
static long long add_one(long long n) {
    return n + 1;
}

int main() {
    long long value = 0;

    for (long long i = 0; i < 100000000LL; ++i) {
        value = add_one(value);
    }

    std::printf("%lld\n", value);
    return 0;
}
