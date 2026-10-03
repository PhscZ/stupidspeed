// task 12 matrix_add — expected output: 999000000
// build: haxe -cp sources/hashlink -main T12_matrix_add -hl temp/hashlink/12_matrix_add.hl
// run: hl temp/hashlink/12_matrix_add.hl
// note: the matrices are flat `Array<Int>` of n*n, indexed i*n+j, exactly like the C row's
//       flat int64 arrays, so the memory layout and the access pattern are the same. Every
//       element here is between -999 and 1998, so the elements are plain 32-bit Int; only the
//       final total needs haxe.Int64, and it is built the same way the C row builds it.
// note: a 32-bit Int stored in a HashLink array is tagged inside the array's 64-bit slot, so
//       the elements are not individually heap-allocated the way a boxed Dynamic would be.

class T12_matrix_add {
    static function main() {
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

        Sys.println(total);
    }
}
