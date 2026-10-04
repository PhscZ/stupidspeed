// task 05 alloc_churn — expected output: 1274991808
// build: javac _05_alloc_churn.java    run: java _05_alloc_churn
// build (graalvm native-image): native-image -O2 _05_alloc_churn    run: ./_05_alloc_churn
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// The 256 slots keep each buffer reachable; the array it replaces becomes garbage for the GC.

public class _05_alloc_churn {
    public static void main(String[] args) {
        long __t0 = System.nanoTime();
        long total = 0;
        byte[][] slots = new byte[256][];
        for (long i = 0; i < 10000000L; i++) {
            int v = (int) (i % 256);
            byte[] buf = new byte[64];
            buf[0] = (byte) v;
            total += v;
            slots[v] = buf;
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(total);
    }
}
