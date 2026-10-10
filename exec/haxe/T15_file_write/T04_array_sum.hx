// task 04 array_sum — expected output: 499999500000
// build: haxe -cp sources/haxe -main T04_array_sum -cpp temp/haxe/04_array_sum -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/04_array_sum/T04_array_sum.exe
// note: `Array<Int>` is a native unboxed int array on cpp, so the million elements are four
//       bytes each, like the C row's array. The sum is 4.999995e11, past 2^31, so it is an
//       haxe.Int64.

class T04_array_sum {
    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        var n = 1000000;
        var array = new Array<Int>();

        for (i in 0...n) {
            array[i] = i;
        }

        var total = haxe.Int64.ofInt(0);
        for (i in 0...n) {
            total += array[i];
        }

        var t1 = haxe.Timer.stamp();
        Out.err("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Out.line(total);
    }
}
