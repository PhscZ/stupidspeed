// task 14 file_read — expected output: 2389704704
// build: haxe -cp sources/haxe -main T14_file_read -cpp temp/haxe/14_file_read -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/14_file_read/T14_file_read.exe   (with data.bin in the working directory)
// note: the file is read in 1 MiB chunks, never a byte per syscall: `FileInput.readBytes` on
//       cpp is a native fread into a haxe.io.Bytes, and each byte of the chunk is then added
//       one at a time in the inner loop, exactly as the C row does it.
// note: the byte sum over 50 MiB is 6684672000, past 2^31, so the total is an haxe.Int64, and
//       the printed value is `total % 4294967296`. That modulus does not fit in Haxe's 32-bit
//       Int, so it is built with Int64.make(1, 0) — 2^32 — and the result prints unsigned.
// note: the read loop is `while` + try/catch rather than C's `while ((got = fread(...)) > 0)`,
//       because cpp's readBytes does not return 0 at end of file: it throws haxe.io.Eof when
//       fread reports nothing at all, and returns a short count only when it stops part-way
//       through a chunk. Catching Eof is therefore the end-of-file test; data.bin is exactly
//       50 whole chunks, so the extra attempt is always the one that ends the loop.

class T14_file_read {
    static inline var CHUNK = 1048576;   // 1 MiB

    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        #if js
        // deviation: the js target has no sys.io at all, so node's fs is the file layer here.
        // readSync into a Uint8Array returns 0 at end of file, so the C-style `got > 0` test
        // works directly and the cpp Eof-catch below is not needed. node gives no fsync story
        // here either, but task 14 only reads.
        var total = haxe.Int64.ofInt(0);
        var fs = js.Syntax.code("require('fs')");
        var fd:Int = fs.openSync("data.bin", "r");
        var buf = new js.lib.Uint8Array(new js.lib.ArrayBuffer(CHUNK));

        while (true) {
            var got:Int = fs.readSync(fd, buf, 0, CHUNK, null);
            if (got <= 0) {
                break;
            }
            for (i in 0...got) {
                total += buf[i];
            }
        }

        fs.closeSync(fd);
        #else
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
        #end

        // 2^32 does not fit in Haxe's 32-bit Int, so it is built with Int64.make(1, 0).
        var modulus = haxe.Int64.make(1, 0);   // 4294967296
        var t1 = haxe.Timer.stamp();
        Out.err("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Out.line(total % modulus);
    }
}
