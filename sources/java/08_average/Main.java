// task 08 average — expected output: 0.498046875
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// Double.toString is locale independent and prints the shortest round-tripping decimal.

public class Main {
    public static void main(String[] args) {
        double total = 0.0;
        for (long i = 0; i < 100000000L; i++) {
            double reading = (i % 256) / 256.0;
            total += reading;
        }
        System.out.println(Double.toString(total / 100000000));
    }
}
