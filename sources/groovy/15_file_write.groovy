// task 15 file_write — expected output: 52428800
// build: none (interpreted)    run: groovy 15_file_write.groovy
// A 1 MiB buffer of the byte cycle 0..255 repeated 4096 times, written 50 times.
// A raw FileOutputStream is used rather than File.withOutputStream because the JVM's
// durability call, getFD().sync(), lives on FileOutputStream; the closure helper hands
// back a BufferedOutputStream, which has no file descriptor.

int chunk = 1024 * 1024
byte[] buf = new byte[chunk]
for (int i = 0; i < chunk; i++) {
    buf[i] = (byte) (i % 256)
}

long written = 0
def out = new FileOutputStream('out.bin')
try {
    for (int t = 0; t < 50; t++) {
        out.write(buf)
        written += chunk
    }
    out.flush()
    out.getFD().sync()
} finally {
    out.close()
}

println written
