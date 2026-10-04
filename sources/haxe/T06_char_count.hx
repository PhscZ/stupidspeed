// task 06 char_count — expected output: 10000000
// build: haxe -cp sources/haxe -main T06_char_count -cpp temp/haxe/06_char_count -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/06_char_count/T06_char_count.exe
// note: the 100000000-byte text is built once, block by block, exactly as the C row does it
//       with memcpy — never by appending in a loop, which is what the task forbids. It is a
//       haxe.io.Bytes rather than a String because the scan is byte-oriented; the block is
//       ASCII, so one byte is one character.

class T06_char_count {
    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        var blockLen = 10;
        var repeats = 10000000;
        var block = haxe.io.Bytes.ofString("abcdefghij");
        var text = haxe.io.Bytes.alloc(repeats * blockLen);

        for (i in 0...repeats) {
            text.blit(i * blockLen, block, 0, blockLen);
        }

        var a = "a".code;
        var e = "e".code;
        var h = "h".code;

        var count = 0;
        for (i in 0...text.length) {
            var ch = text.get(i);
            if (ch == a) {
                continue;
            } else if (ch == e) {
                continue;
            } else if (ch == h) {
                count += 1;
            }
        }

        var t1 = haxe.Timer.stamp();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(count);
    }
}
