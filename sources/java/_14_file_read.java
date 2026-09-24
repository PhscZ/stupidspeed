// task 14 file_read — expected output: 484442112
// build: javac _14_file_read.java    run: java _14_file_read
// build (graalvm native-image): native-image -O2 _14_file_read    run: ./_14_file_read
// Reads data.bin from the working directory in 1 MiB chunks; bytes are unsigned via & 0xFF.

import java.io.FileInputStream;
import java.io.IOException;

public class _14_file_read {
    public static void main(String[] args) throws IOException {
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
        System.out.println(total % 4294967296L);
    }
}
