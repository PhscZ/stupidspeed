// task 15 file_write — expected output: 419430400
// build: javac _15_file_write.java    run: java _15_file_write
// build (graalvm native-image): native-image -O2 _15_file_write    run: ./_15_file_write
// run (graalvm jit): the same javac class file under GraalVM's java, which enables the Graal JIT by default
// run (loom): the same javac class file on a JDK 21+; task 11's loom variant is sources/java-loom/_11_parallel_sum.java
// Writes the 1 MiB 0..255 pattern 50 times per pass over 8 passes, each pass reopening
// out.bin (FileOutputStream truncates) at offset 0 and ending with flush() and fsync via
// getFD().sync().

import java.io.FileOutputStream;
import java.io.IOException;

public class _15_file_write {
    public static void main(String[] args) throws IOException {
        long __t0 = System.nanoTime();
        byte[] buf = new byte[1024 * 1024];
        for (int i = 0; i < buf.length; i++) {
            buf[i] = (byte) (i % 256);
        }
        long written = 0;
        for (int pass = 0; pass < 8; pass++) {
            try (FileOutputStream out = new FileOutputStream("out.bin")) {
                for (int i = 0; i < 50; i++) {
                    out.write(buf);
                    written += buf.length;
                }
                out.flush();
                out.getFD().sync();
            }
        }
        System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6);
        System.out.println(written);
    }
}
