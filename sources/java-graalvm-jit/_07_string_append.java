// task 07 string_append — expected output: 250000
// build: javac _07_string_append.java    run: java _07_string_append
// build (graalvm native-image): native-image -O2 _07_string_append    run: ./_07_string_append
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// Plain String concatenation: every append copies the whole string. No StringBuilder here.

public class _07_string_append {
    public static void main(String[] args) {
        String text = "";
        for (int i = 0; i < 250000; i++) {
            text = text + "x";
        }
        System.out.println(text.length());
    }
}
