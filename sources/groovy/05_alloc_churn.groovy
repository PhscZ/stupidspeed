// task 05 alloc_churn — expected output: 1274991808
// build: none (interpreted)    run: groovy 05_alloc_churn.groovy
// Ten million 64-byte arrays, with the slot store dropping the buffer it replaces.
// The JVM has a garbage collector, so the replaced array becomes garbage.

byte[][] slots = new byte[256][]
long total = 0

for (int i = 0; i < 10000000; i++) {
    byte[] buf = new byte[64]
    buf[0] = (byte) (i % 256)
    total += (buf[0] & 0xFF)
    slots[i % 256] = buf
}

println total
