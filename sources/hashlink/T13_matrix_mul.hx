// task 13 matrix_mul — expected output: 599995000
// build: haxe -cp sources/hashlink -main T13_matrix_mul -hl temp/hashlink/13_matrix_mul.hl
// run: hl temp/hashlink/13_matrix_mul.hl
// note: flat `Array<Int>` of n*n again, and the plain i, j, k triple loop in that order, so the
//       access pattern is the C row's. The inner sum is at most 500 * 6 * 4 = 12000, so it
//       stays in 32 bits; only the final total is an haxe.Int64.

class T13_matrix_mul {
    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
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

        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(total);
    }
}
