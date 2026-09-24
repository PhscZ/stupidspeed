// task 07 string_append — expected output: 1000000
// build: javac _07_string_append.java    run: java _07_string_append
// build (graalvm native-image): native-image -O2 _07_string_append    run: ./_07_string_append
// Plain String concatenation: every append copies the whole string. No StringBuilder here.

public class _07_string_append {
    public static void main(String[] args) {
        String text = "";
        for (int i = 0; i < 1000000; i++) {
            text = text + "x";
        }
        System.out.println(text.length());
    }
}
