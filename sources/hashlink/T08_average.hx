// task 08 average — expected output: 0.498046875
// build: haxe -cp sources/hashlink -main T08_average -hl temp/hashlink/08_average.hl
// run: hl temp/hashlink/08_average.hl
// note: `Float` is a 64-bit double on this target too — HashLink has an F64 register type and
//       Haxe's Float maps straight onto it. The divisor is written 256.0 so the division is
//       floating point; `(i % 256) / 256` would be integer division in Haxe.
// note: 100000000 readings is exactly the multiple of 256 the task's exact answer relies on,
//       so the sum is a multiple of 1/256 and the printed double is exact, not rounded.

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
