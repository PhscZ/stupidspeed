// task 15 file_write — expected output: 104857600
// build: none (interpreted)    run: groovy 15_file_write.groovy
// A 1 MiB buffer of the byte cycle 0..255 repeated 4096 times, written 100 times.

int chunk = 1024 * 1024
byte[] buf = new byte[chunk]
for (int i = 0; i < chunk; i++) {
    buf[i] = (byte) (i % 256)
}

long written = 0
new File('out.bin').withOutputStream { out ->
    for (int t = 0; t < 100; t++) {
        out.write(buf)
        written += chunk
    }
    out.flush()
}

println written
