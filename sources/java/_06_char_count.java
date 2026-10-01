// task 06 char_count — expected output: 10000000
// build: javac _06_char_count.java    run: java _06_char_count
// build (graalvm native-image): native-image -O2 _06_char_count    run: ./_06_char_count
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// The 100 MB text is built once with String.repeat, then scanned one char at a time.

public class _06_char_count {
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
