// task 04 array_sum — expected output: 499999500000
// build: javac _04_array_sum.java    run: java _04_array_sum
// build (graalvm native-image): native-image -O2 _04_array_sum    run: ./_04_array_sum

public class _04_array_sum {
    public static void main(String[] args) {
        final int n = 1000000;
        long[] array = new long[n];
        for (int i = 0; i < n; i++) {
            array[i] = i;
        }
        long total = 0;
        for (int i = 0; i < n; i++) {
            total += array[i];
        }
        System.out.println(total);
    }
}
