// task 06 char_count — expected output: 10000000
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// The 100 MB text is built once with String.repeat, then scanned one char at a time.

public class Main {
    public static void main(String[] args) {
        String text = "abcdefghij".repeat(10000000);
        long count = 0;
        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) == 'h') {
                count += 1;
            }
        }
        System.out.println(count);
    }
}
