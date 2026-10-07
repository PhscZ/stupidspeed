// task 09 fib_recursive — expected output: 102334155
// build: haxe -cp sources/haxe -main T09_fib_recursive -cpp temp/haxe/09_fib_recursive -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/09_fib_recursive/T09_fib_recursive.exe
// note: fib(40) is 102334155, which still fits in Haxe's 32-bit Int, so no Int64 is needed.

class T09_fib_recursive {
    static function fib(n:Int):Int {
        if (n < 2) {
            return n;
        }
        return fib(n - 1) + fib(n - 2);
    }

    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        var answer = fib(40);
        var t1 = haxe.Timer.stamp();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(answer);
    }
}
