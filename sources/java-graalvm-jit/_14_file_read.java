// task 14 file_read — expected output: 2389704704
// build: javac _14_file_read.java    run: java _14_file_read
// build (graalvm native-image): native-image -O2 _14_file_read    run: ./_14_file_read
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// Reads data.bin from the working directory in 1 MiB chunks; bytes are unsigned via & 0xFF.

import java.io.FileInputStream;
import java.io.IOException;

public class _14_file_read {
    public static void main(String[] args) throws IOException {
        long __t0 = System.nanoTime();
        byte[] buf = new byte[1024 * 1024];
        long total = 0;
        try (FileInputStream in = new FileInputStream("data.bin")) {
            int n;
            while ((n = in.read(buf)) != -1) {
                for (int i = 0; i < n; i++) {
                    total += buf[i] & 0xFF;
                }
            }
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(total % 4294967296L);
    }
}
