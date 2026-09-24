// task 02 switch_case — expected output: 7500000075000000
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main

public class Main {
    public static void main(String[] args) {
        long acc = 0;
        for (long i = 0; i < 100000000L; i++) {
            switch ((int) (i % 4)) {
                case 0:
                    acc += 1;
                    break;
                case 1:
                    acc += i;
                    break;
                case 2:
                    acc += 2 * i;
                    break;
                case 3:
                    acc += 3 * i;
                    break;
            }
        }
        System.out.println(acc);
    }
}
