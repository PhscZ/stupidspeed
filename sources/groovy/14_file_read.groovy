// task 14 file_read — expected output: 2389704704
// build: none (interpreted)    run: groovy 14_file_read.groovy
// One pass over 50 MiB, reading 1 MiB at a time.

byte[] buf = new byte[1024 * 1024]
long __t0 = System.nanoTime()
long total = 0

new File('data.bin').withInputStream { input ->
    while (true) {
        int got = input.read(buf)
        if (got <= 0) { break }
        for (int i = 0; i < got; i++) {
            total += (buf[i] & 0xFF)
        }
    }
}

System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
println(total % 4294967296L)
