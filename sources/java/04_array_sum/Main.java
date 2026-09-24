// task 04 array_sum — expected output: 499999500000
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main

public class Main {
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
