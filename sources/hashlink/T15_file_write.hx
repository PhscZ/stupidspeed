// task 15 file_write — expected output: 52428800
// build: haxe -cp sources/hashlink -main T15_file_write -hl temp/hashlink/15_file_write.hl
// run: hl temp/hashlink/15_file_write.hl           (writes out.bin to the working directory)
// note: deviation — there is no fsync in the Haxe standard library. `sys.io.FileOutput` adds
//       only seek and tell beyond haxe.io.Output, `flush()` on HashLink is the native
//       file_flush, and nothing in sys.io or haxe.io exposes a descriptor or handle to call
//       FlushFileBuffers on. The row therefore writes the 1 MiB buffer 50 times, flushes and
//       closes, where the C row adds _commit. The file is complete and 52428800 bytes long
//       either way; what is missing is the guarantee that it has reached the platter when the
//       program returns.
// note: `File.write(path, true)` opens the file "wb", so this is a binary write and the byte
//       cycle 0..255 is written verbatim. `writeBytes` returns the number of bytes written,
//       which is what the task prints.

class T15_file_write {
    static inline var CHUNK = 1048576;   // 1 MiB
    static inline var REPEATS = 50;

    static function main() {
        var buf = haxe.io.Bytes.alloc(CHUNK);
        for (i in 0...CHUNK) {
            buf.set(i, i % 256);
        }

        var f = sys.io.File.write("out.bin", true);

        var written = 0;
        for (i in 0...REPEATS) {
            written += f.writeBytes(buf, 0, CHUNK);
        }

        f.flush();
        f.close();

        Sys.println(written);
    }
}
