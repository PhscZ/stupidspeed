// task 09 fib_recursive — expected output: 102334155
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// Naive double recursion, no memoization.

public class Main {
    private static long fib(long n) {
        if (n < 2) {
            return n;
        }
        return fib(n - 1) + fib(n - 2);
    }

    public static void main(String[] args) {
        System.out.println(fib(40));
    }
}
