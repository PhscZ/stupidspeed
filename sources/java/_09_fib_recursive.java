// task 09 fib_recursive — expected output: 102334155
// build: javac _09_fib_recursive.java    run: java _09_fib_recursive
// build (graalvm native-image): native-image -O2 _09_fib_recursive    run: ./_09_fib_recursive
// Naive double recursion, no memoization.

public class _09_fib_recursive {
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
