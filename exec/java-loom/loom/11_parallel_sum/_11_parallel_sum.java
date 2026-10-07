// task 11 parallel_sum — expected output: 7500000075000000
// build: javac -d . _11_parallel_sum.java    run: java -cp . _11_parallel_sum
// The Loom variant of the java row's task 11: the same four fixed quarters, but the workers are
// virtual threads (Thread.ofVirtual) instead of platform threads. Everything else in the file is
// the openjdk row's task 11 unchanged.

public class _11_parallel_sum {
    private static final long SPAN = 25000000L;

    private static long work(long t) {
        long start = t * SPAN;
        long end = start + SPAN;
        long acc = 0;
        for (long i = start; i < end; i++) {
            switch ((int) (i % 4)) {
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
        return acc;
    }

    public static void main(String[] args) throws InterruptedException {
        long __t0 = System.nanoTime();
        long[] results = new long[4];
        Thread[] threads = new Thread[4];
        for (int t = 0; t < 4; t++) {
            final int id = t;
            threads[t] = Thread.ofVirtual().name("worker-" + t).unstarted(() -> results[id] = work(id));
        }
        for (Thread th : threads) {
            th.start();
        }
        for (Thread th : threads) {
            th.join();
        }
        long total = 0;
        for (int t = 0; t < 4; t++) {
            total += results[t];
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(total);
    }
}
