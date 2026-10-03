// task 11 parallel_sum — expected output: 7500000075000000
// build: g++ -O2 -pthread -o prog 11_parallel_sum.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog 11_parallel_sum.cpp | cl /O2 /EHsc /Fe:prog 11_parallel_sum.cpp
// note: four std::thread workers own disjoint ranges and write their own slot of results[],
//       so the total does not depend on how the threads are scheduled.

#include <cstdio>
#include <thread>

static const long long CHUNK = 25000000LL;

static void work(int t, long long* results) {
    long long acc = 0;
    const long long begin = static_cast<long long>(t) * CHUNK;
    const long long end = begin + CHUNK;

    for (long long i = begin; i < end; ++i) {
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

    results[t] = acc;
}

int main() {
    const int workers = 4;
    long long results[4] = {0, 0, 0, 0};
    std::thread threads[4];

    for (int t = 0; t < workers; ++t) {
        threads[t] = std::thread(work, t, results);
    }

    for (int t = 0; t < workers; ++t) {
        threads[t].join();
    }

    long long total = 0;
    for (int t = 0; t < workers; ++t) {
        total += results[t];
    }

    std::printf("%lld\n", total);
    return 0;
}
