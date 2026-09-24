// task 14 file_read — expected output: 484442112
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// Reads data.bin from the working directory in 1 MiB chunks; bytes are unsigned via & 0xFF.

import java.io.FileInputStream;
import java.io.IOException;

public class Main {
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
