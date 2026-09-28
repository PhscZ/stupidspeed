// task 15 file_write — expected output: 52428800
// build: javac _15_file_write.java    run: java _15_file_write
// build (graalvm native-image): native-image -O2 _15_file_write    run: ./_15_file_write
// Writes the 1 MiB 0..255 pattern 50 times, then flush() and fsync via getFD().sync().

import java.io.FileOutputStream;
import java.io.IOException;

public class _15_file_write {
    public static void main(String[] args) throws IOException {
        byte[] buf = new byte[1024 * 1024];
        for (int i = 0; i < buf.length; i++) {
            buf[i] = (byte) (i % 256);
        }
        long written = 0;
        try (FileOutputStream out = new FileOutputStream("out.bin")) {
            for (int i = 0; i < 50; i++) {
                out.write(buf);
                written += buf.length;
            }
            out.flush();
            out.getFD().sync();
        }
        System.out.println(written);
    }
}
