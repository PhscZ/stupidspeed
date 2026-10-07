// task 11 parallel_sum — expected output: 7500000075000000
// build: javac _11_parallel_sum.java    run: java _11_parallel_sum
// build (graalvm native-image): native-image -O2 _11_parallel_sum    run: ./_11_parallel_sum
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// Four real OS threads (java.lang.Thread) over fixed ranges; the partial sums are exact in long.

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
            threads[t] = new Thread(() -> results[id] = work(id));
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
