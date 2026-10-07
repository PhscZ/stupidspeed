// task 07 string_append — expected output: 250000
// build: haxe -cp sources/hashlink -main T07_string_append -hl temp/hashlink/07_string_append.hl
// run: hl temp/hashlink/07_string_append.hl
// note: `text += "x"` is the honest quadratic route: a Haxe String is immutable, so the
//       iteration count and the copied bytes are the same shape as the C row's realloc +
//       strcat. This is the slowest cell of the row by a wide margin (tens of seconds) and
//       that is the point of the task.
// note: StringBuf is deliberately NOT used. It is documented as "an efficient way to build a
//       big string by appending small elements", and using it would quietly turn this cell
//       into a different measurement.

class T07_string_append {
    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
        var text = "";

        for (i in 0...250000) {
            text += "x";
        }

        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(text.length);
    }
}
