// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: haxe -cp sources/haxe -main T01_branches -cpp temp/haxe/01_branches -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/01_branches/T01_branches.exe
// note: Haxe ties a type name to its file name and a type name must start with an uppercase
//       letter, so `01_branches.hx` is not a legal module. The row uses the Ada row's
//       `t01_branches.adb` pattern: `T01_branches.hx`, class T01_branches. Every file in this
//       directory is named that way.
// note: Haxe's `Int` is 32 bits on every target, so the four counters are `Int` here; the
//       largest of them, 45714285, fits. Tasks whose total does not fit use `haxe.Int64`.

class T01_branches {
    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        var a = 0;
        var b = 0;
        var c = 0;
        var d = 0;

        for (i in 0...100000000) {
            if (i % 3 == 0) {
                a += 1;
            } else if (i % 5 == 0) {
                b += 1;
            } else if (i % 7 == 0) {
                c += 1;
            } else {
                d += 1;
            }
        }

        var t1 = haxe.Timer.stamp();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println('$a $b $c $d');
    }
}
