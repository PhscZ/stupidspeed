// task 02 switch_case — expected output: 7500000075000000
// build: javac _02_switch_case.java    run: java _02_switch_case
// build (graalvm native-image): native-image -O2 _02_switch_case    run: ./_02_switch_case
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java

public class _02_switch_case {
    public static void main(String[] args) {
        long __t0 = System.nanoTime();
        long acc = 0;
        for (long i = 0; i < 100000000L; i++) {
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
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(acc);
    }
}
