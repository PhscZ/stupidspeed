// task 09 fib_recursive — expected output: 102334155
// build: haxe -cp sources/hashlink -main T09_fib_recursive -hl temp/hashlink/09_fib_recursive.hl
// run: hl temp/hashlink/09_fib_recursive.hl
// note: fib(40) is 102334155, which still fits in Haxe's 32-bit Int, so no Int64 is needed.
// note: the call tree is about 3.3e8 calls deep in total but only 40 frames deep at any one
//       moment, so the VM's native stack is never in question.

class T09_fib_recursive {
    static function fib(n:Int):Int {
        if (n < 2) {
            return n;
        }
        return fib(n - 1) + fib(n - 2);
    }

    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
        var answer = fib(40);
        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(answer);
    }
}
