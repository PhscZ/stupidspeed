// task 13 matrix_mul — expected output: 599995000
// build: haxe -cp sources/haxe -main T13_matrix_mul -cpp temp/haxe/13_matrix_mul -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/13_matrix_mul/T13_matrix_mul.exe
// note: flat `Array<Int>` of n*n again, and the plain i, j, k triple loop in that order. The
//       inner sum is at most 500 * 6 * 4 = 12000, so it stays in 32 bits; only the final
//       total is an haxe.Int64.

class T13_matrix_mul {
    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        var n = 500;
        var elems = n * n;

        var a = new Array<Int>();
        var b = new Array<Int>();
        var c = new Array<Int>();

        for (i in 0...n) {
            for (j in 0...n) {
                a[i * n + j] = (i + j) % 7;
                b[i * n + j] = (i * j) % 5;
            }
        }

        for (i in 0...n) {
            for (j in 0...n) {
                var sum = 0;
                for (k in 0...n) {
                    sum += a[i * n + k] * b[k * n + j];
                }
                c[i * n + j] = sum;
            }
        }

        var total = haxe.Int64.ofInt(0);
        for (k in 0...elems) {
            total += c[k];
        }

        var t1 = haxe.Timer.stamp();
        Out.err("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Out.line(total);
    }
}
