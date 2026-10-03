// task 07 string_append — expected output: 250000
// build: haxe -cp sources/haxe -main T07_string_append -cpp temp/haxe/07_string_append -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/07_string_append/T07_string_append.exe
// note: `text += "x"` is the honest quadratic route: a Haxe String is immutable, so every
//       iteration allocates a fresh string and copies the whole of the old one, which is what
//       the C row's realloc + strcat does.
// note: StringBuf is deliberately NOT used. It is documented as "an efficient way to build a
//       big string by appending small elements", and on cpp it is literally an Array<String>
//       with a push and a join at toString(), i.e. linear. Using it would quietly turn this
//       cell into a different measurement.

class T07_string_append {
    static function main() {
        var text = "";

        for (i in 0...250000) {
            text += "x";
        }

        Sys.println(text.length);
    }
}
