// task 07 string_append — expected output: 1000000
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// Plain String concatenation: every append copies the whole string. No StringBuilder here.

public class Main {
    public static void main(String[] args) {
        String text = "";
        for (int i = 0; i < 1000000; i++) {
            text = text + "x";
        }
        System.out.println(text.length());
    }
}
