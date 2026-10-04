// task 14 file_read — expected output: 2389704704
// build: haxe -cp sources/hashlink -main T14_file_read -hl temp/hashlink/14_file_read.hl
// run: hl temp/hashlink/14_file_read.hl            (from the repository root, where data.bin is)
// note: the file is read in 1 MiB chunks, never a byte per syscall: `FileInput.readBytes` on
//       HashLink is a native file_read into a haxe.io.Bytes, and each byte of the chunk is
//       then added one at a time in the inner loop, exactly as the C row does it.
// note: the byte sum over 50 MiB is 6684672000, past 2^31, so the total is an haxe.Int64, and
//       the printed value is `total % 4294967296`. That modulus does not fit in Haxe's 32-bit
//       Int, so it is built with Int64.make(1, 0) — 2^32 — and the result prints unsigned.
// note: the read loop is `while` + try/catch rather than C's `while ((got = fread(...)) > 0)`,
//       because HashLink's readBytes does not return 0 at end of file: it throws haxe.io.Eof
//       when the native read reports nothing at all, and returns a short count only when it
//       stops part-way through a chunk. Catching Eof is therefore the end-of-file test;
//       data.bin is exactly 50 whole chunks, so the extra attempt is always the one that ends
//       the loop.

class T14_file_read {
    static inline var CHUNK = 1048576;   // 1 MiB

    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
        var f = sys.io.File.read("data.bin", true);
        var buf = haxe.io.Bytes.alloc(CHUNK);

        var total = haxe.Int64.ofInt(0);
        while (true) {
            var got = 0;
            try {
                got = f.readBytes(buf, 0, CHUNK);
            } catch (e:haxe.io.Eof) {
                break;
            }
            for (i in 0...got) {
                total += buf.get(i);
            }
        }

        f.close();

        var modulus = haxe.Int64.make(1, 0);   // 4294967296
        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(total % modulus);
    }
}
