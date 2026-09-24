// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main

public class Main {
    public static void main(String[] args) {
        long a = 0, b = 0, c = 0, d = 0;
        for (long i = 0; i < 100000000L; i++) {
            if (i % 3 == 0) {
                a += 1;
            } else if (i % 5 == 0) {
                b += 1;
            } else if (i % 7 == 0) {
                c += 1;
            } else {
                d += 1;
            }
        }
        System.out.println(a + " " + b + " " + c + " " + d);
    }
}
