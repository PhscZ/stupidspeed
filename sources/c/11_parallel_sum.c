// task 11 parallel_sum — expected output: 7500000075000000
// build: gcc -O2 -pthread -o prog 11_parallel_sum.c    run: ./prog
// alternates: clang -O2 -pthread -o prog 11_parallel_sum.c | cl /O2 /Fe:prog 11_parallel_sum.c | tcc -o prog 11_parallel_sum.c

#include <stdio.h>
#include <stdint.h>

#define THREADS 4
#define SPAN 25000000LL

typedef struct {
    int64_t t;
    int64_t acc;
} Job;

static int64_t work_range(int64_t t) {
    int64_t acc = 0;
    int64_t lo = t * SPAN;
    int64_t hi = lo + SPAN;

    for (int64_t i = lo; i < hi; i++) {
        switch (i % 4) {
            case 0: acc += 1; break;
            case 1: acc += i; break;
            case 2: acc += 2 * i; break;
            case 3: acc += 3 * i; break;
        }
    }
    return acc;
}

#if defined(_WIN32)

#include <windows.h>

static DWORD WINAPI worker(LPVOID arg) {
    Job *job = (Job *)arg;
    job->acc = work_range(job->t);
    return 0;
}

int main(void) {
    Job jobs[THREADS];
    HANDLE threads[THREADS];

    for (int t = 0; t < THREADS; t++) {
        jobs[t].t = t;
        jobs[t].acc = 0;
        threads[t] = CreateThread(NULL, 0, worker, &jobs[t], 0, NULL);
    }
    for (int t = 0; t < THREADS; t++) {
        WaitForSingleObject(threads[t], INFINITE);
    }
    for (int t = 0; t < THREADS; t++) {
        CloseHandle(threads[t]);
    }

    int64_t total = 0;
    for (int t = 0; t < THREADS; t++) {
        total += jobs[t].acc;
    }

    printf("%lld\n", (long long)total);
    return 0;
}

#else

#include <pthread.h>

static void *worker(void *arg) {
    Job *job = (Job *)arg;
    job->acc = work_range(job->t);
    return NULL;
}

int main(void) {
    Job jobs[THREADS];
    pthread_t threads[THREADS];

    for (int t = 0; t < THREADS; t++) {
        jobs[t].t = t;
        jobs[t].acc = 0;
        pthread_create(&threads[t], NULL, worker, &jobs[t]);
    }
    for (int t = 0; t < THREADS; t++) {
        pthread_join(threads[t], NULL);
    }

    int64_t total = 0;
    for (int t = 0; t < THREADS; t++) {
        total += jobs[t].acc;
    }

    printf("%lld\n", (long long)total);
    return 0;
}

#endif
