// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: javac _01_branches.java    run: java _01_branches
// build (graalvm native-image): native-image -O2 _01_branches    run: ./_01_branches
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java

public class _01_branches {
    public static void main(String[] args) {
        long __t0 = System.nanoTime();
        long a = 0, b = 0, c = 0, d = 0;
        for (long i = 0; i < 100000000L; i++) {
            if (i % 3 == 0) {
                a += 1;
            } else if (i % 5 == 0) {
                b += 1;
            } else if (i % 7 == 0) {
                c += 1;
            } else {
                d += 1;
            }
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(a + " " + b + " " + c + " " + d);
    }
}
