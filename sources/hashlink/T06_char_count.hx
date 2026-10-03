// task 06 char_count — expected output: 10000000
// build: haxe -cp sources/hashlink -main T06_char_count -hl temp/hashlink/06_char_count.hl
// run: hl temp/hashlink/06_char_count.hl
// note: the 100000000-byte text is built once, block by block, exactly as the C row does it
//       with memcpy — never by appending in a loop, which is what the task forbids. It is a
//       haxe.io.Bytes rather than a String because the scan is byte-oriented; the block is
//       ASCII, so one byte is one character. `Bytes.blit` is the VM's byte copy.

class T06_char_count {
    static function main() {
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

        Sys.println(count);
    }
}
