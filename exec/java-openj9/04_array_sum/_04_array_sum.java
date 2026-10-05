// task 04 array_sum — expected output: 499999500000
// build: javac _04_array_sum.java    run: java _04_array_sum
// build (graalvm native-image): native-image -O2 _04_array_sum    run: ./_04_array_sum
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java

public class _04_array_sum {
    public static void main(String[] args) {
        long __t0 = System.nanoTime();
        final int n = 1000000;
        long[] array = new long[n];
        for (int i = 0; i < n; i++) {
            array[i] = i;
        }
        long total = 0;
        for (int i = 0; i < n; i++) {
            total += array[i];
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(total);
    }
}
