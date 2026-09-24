// task 13 matrix_mul — expected output: 599995000
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// Plain i,j,k triple loop in that order, no reordering, no library multiply.

public class Main {
    public static void main(String[] args) {
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
        System.out.println(total);
    }
}
