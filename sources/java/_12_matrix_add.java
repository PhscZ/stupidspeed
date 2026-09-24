// task 12 matrix_add — expected output: 999000000
// build: javac _12_matrix_add.java    run: java _12_matrix_add
// build (graalvm native-image): native-image -O2 _12_matrix_add    run: ./_12_matrix_add
// Flat long[n*n] arrays with index i*n+j.

public class _12_matrix_add {
    public static void main(String[] args) {
        final int n = 1000;
        long[] a = new long[n * n];
        long[] b = new long[n * n];
        long[] c = new long[n * n];

        for (int i = 0; i < n; i++) {
            int row = i * n;
            for (int j = 0; j < n; j++) {
                a[row + j] = i + j;
                b[row + j] = i - j;
            }
        }
        for (int i = 0; i < n; i++) {
            int row = i * n;
            for (int j = 0; j < n; j++) {
                c[row + j] = a[row + j] + b[row + j];
            }
        }

        long total = 0;
        for (int idx = 0; idx < n * n; idx++) {
            total += c[idx];
        }
        System.out.println(total);
    }
}
