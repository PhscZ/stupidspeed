// task 03 func_sum — expected output: 100000000
// build: javac _03_func_sum.java    run: java _03_func_sum
// build (graalvm native-image): native-image -O2 -H:NeverInline=_03_func_sum.addOne _03_func_sum    run: ./_03_func_sum
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// The JVM has no portable no-inline attribute, so addOne is a plain static method;
// HotSpot may still inline it, which would make this task measure only the loop.
// GraalVM native-image does worse than inline it: with a constant bound and a
// constant start, it constant-folds the whole loop at build time, and the cell
// measured nothing -- TIME_MS 0.0001, against 31 ms for the same source built -O0
// (both measured). The java-graalvm-native row therefore builds this one task with
// -H:NeverInline=_03_func_sum.addOne, native-image's own no-inline lever, which is
// what the C row's __attribute__((noinline)) is to gcc: a real call, 75 ms.

public class _03_func_sum {
    private static long addOne(long n) {
        return n + 1;
    }

    public static void main(String[] args) {
        long __t0 = System.nanoTime();
        long value = 0;
        for (long i = 0; i < 100000000L; i++) {
            value = addOne(value);
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(value);
    }
}
