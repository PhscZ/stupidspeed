// task 08 average — expected output: 0.498046875
// build: haxe -cp sources/haxe -main T08_average -cpp temp/haxe/08_average -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/08_average/T08_average.exe
// note: `Float` is a 64-bit double on cpp. The divisor is written 256.0 so the division is
//       floating point; `(i % 256) / 256` would be integer division in Haxe.

class T08_average {
    static function main() {
        var total = 0.0;

        for (i in 0...100000000) {
            var reading = (i % 256) / 256.0;
            total += reading;
        }

        Sys.println(total / 100000000.0);
    }
}
