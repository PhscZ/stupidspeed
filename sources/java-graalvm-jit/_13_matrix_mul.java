// task 13 matrix_mul — expected output: 599995000
// build: javac _13_matrix_mul.java    run: java _13_matrix_mul
// build (graalvm native-image): native-image -O2 _13_matrix_mul    run: ./_13_matrix_mul
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// Plain i,j,k triple loop in that order, no reordering, no library multiply.

public class _13_matrix_mul {
    public static void main(String[] args) {
        long __t0 = System.nanoTime();
        final int n = 500;
        long[] a = new long[n * n];
        long[] b = new long[n * n];
        long[] c = new long[n * n];

        for (int i = 0; i < n; i++) {
            int row = i * n;
            for (int j = 0; j < n; j++) {
                a[row + j] = (i + j) % 7;
                b[row + j] = (i * j) % 5;
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                long sum = 0;
                for (int k = 0; k < n; k++) {
                    sum += a[i * n + k] * b[k * n + j];
                }
                c[i * n + j] = sum;
            }
        }

        long total = 0;
        for (int idx = 0; idx < n * n; idx++) {
            total += c[idx];
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(total);
    }
}
