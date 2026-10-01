// task 08 average — expected output: 0.498046875
// build: javac _08_average.java    run: java _08_average
// build (graalvm native-image): native-image -O2 _08_average    run: ./_08_average
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// Double.toString is locale independent and prints the shortest round-tripping decimal.

public class _08_average {
    public static void main(String[] args) {
        double total = 0.0;
        for (long i = 0; i < 100000000L; i++) {
            double reading = (i % 256) / 256.0;
            total += reading;
        }
        System.out.println(Double.toString(total / 100000000));
    }
}
