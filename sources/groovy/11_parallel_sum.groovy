// task 11 parallel_sum — expected output: 7500000075000000
// build: none (interpreted)    run: groovy 11_parallel_sum.groovy
// Four real OS threads (java.lang.Thread) over fixed quarters of task 02's range.
// Unlike CPython and CRuby the JVM has no global interpreter lock, so this really
// uses four cores.

private static long work(long t) {
    long start = t * 25000000L
    long end = start + 25000000L
    long acc = 0
    for (long i = start; i < end; i++) {
        switch ((int) (i % 4)) {
            case 0: acc += 1; break
            case 1: acc += i; break
            case 2: acc += 2L * i; break
            default: acc += 3L * i; break
        }
    }
    return acc
}

long[] partials = new long[4]
Thread[] workers = new Thread[4]

for (int t = 0; t < 4; t++) {
    final int id = t
    workers[t] = new Thread({ -> partials[id] = work(id) } as Runnable)
}

for (Thread w : workers) { w.start() }
for (Thread w : workers) { w.join() }

long total = 0
for (long p : partials) { total += p }

println total
