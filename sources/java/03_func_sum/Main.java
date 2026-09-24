// task 03 func_sum — expected output: 100000000
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// The JVM has no portable no-inline attribute, so addOne is a plain static method;
// HotSpot may still inline it, which would make this task measure only the loop.

public class Main {
    private static long addOne(long n) {
        return n + 1;
    }

    public static void main(String[] args) {
        long value = 0;
        for (long i = 0; i < 100000000L; i++) {
            value = addOne(value);
        }
        System.out.println(value);
    }
}
