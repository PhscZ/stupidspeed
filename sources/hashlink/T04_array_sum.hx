// task 04 array_sum — expected output: 499999500000
// build: haxe -cp sources/hashlink -main T04_array_sum -hl temp/hashlink/04_array_sum.hl
// run: hl temp/hashlink/04_array_sum.hl
// note: `Array<Int>` on HashLink is the VM's native dynamic array; a 32-bit Int stored in one
//       is tagged inside the 64-bit value itself, so the million elements are compact and no
//       box is allocated per element. The array is filled first and summed afterwards, exactly
//       as the C row does.
// note: the sum is 4.999995e11, past 2^31, so the accumulator is haxe.Int64.

class T04_array_sum {
    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
        var n = 1000000;
        var array = new Array<Int>();

        for (i in 0...n) {
            array[i] = i;
        }

        var total = haxe.Int64.ofInt(0);
        for (i in 0...n) {
            total += array[i];
        }

        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(total);
    }
}
