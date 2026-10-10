// task 15 file_write — expected output: 52428800
// build: haxe -cp sources/haxe -main T15_file_write -cpp temp/haxe/15_file_write -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/15_file_write/T15_file_write.exe   (writes out.bin to the working directory)
// note: deviation — there is no fsync in the Haxe standard library. `sys.io.FileOutput` adds
//       only seek and tell beyond haxe.io.Output, `flush()` on cpp is fflush, and nothing in
//       sys.io or haxe.io exposes a descriptor or handle to call FlushFileBuffers on. The row
//       therefore writes the 1 MiB buffer 50 times, flushes and closes, where the C row adds
//       _commit. The file is complete and 52428800 bytes long either way; what is missing is
//       the guarantee that it has reached the platter when the program returns.
// note: `File.write(path, true)` opens the file "wb", so this is a binary write and the byte
//       cycle 0..255 is written verbatim.

class T15_file_write {
    static inline var CHUNK = 1048576;   // 1 MiB
    static inline var REPEATS = 50;

    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        #if js
        // deviation, two of them: the js target has no sys.io at all, so node's fs is the file
        // layer here; and node's openSync("w") truncates, which File.write(path, true) also
        // does on the other targets, so the byte cycle 0..255 is what lands in the file.
        var fs = js.Syntax.code("require('fs')");
        var buf = new js.lib.Uint8Array(new js.lib.ArrayBuffer(CHUNK));
        for (i in 0...CHUNK) {
            buf[i] = i % 256;
        }

        var fd:Int = fs.openSync("out.bin", "w");

        var written = 0;
        for (i in 0...REPEATS) {
            written += fs.writeSync(fd, buf, 0, CHUNK);
        }

        fs.closeSync(fd);
        #else
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
        #end

        var t1 = haxe.Timer.stamp();
        Out.err("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Out.line(written);
    }
}
