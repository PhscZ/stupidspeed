// task 12 matrix_add — expected output: 999000000
// build: haxe -cp sources/haxe -main T12_matrix_add -cpp temp/haxe/12_matrix_add -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/12_matrix_add/T12_matrix_add.exe
// note: the matrices are flat `Array<Int>` of n*n, indexed i*n+j, exactly like the C row's
//       flat int64 arrays, so the memory layout and the access pattern are the same. Every
//       element here is between -999 and 1998, so the elements are plain 32-bit Int; only the
//       final total needs haxe.Int64, and it is built the same way the C row builds it.

class T12_matrix_add {
    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        var n = 1000;
        var elems = n * n;

        var a = new Array<Int>();
        var b = new Array<Int>();
        var c = new Array<Int>();

        for (i in 0...n) {
            for (j in 0...n) {
                a[i * n + j] = i + j;
                b[i * n + j] = i - j;
            }
        }

        for (i in 0...n) {
            for (j in 0...n) {
                c[i * n + j] = a[i * n + j] + b[i * n + j];
            }
        }

        var total = haxe.Int64.ofInt(0);
        for (k in 0...elems) {
            total += c[k];
        }

        var t1 = haxe.Timer.stamp();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(total);
    }
}
