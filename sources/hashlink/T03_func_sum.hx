// task 03 func_sum — expected output: 100000000
// build: haxe -cp sources/hashlink -main T03_func_sum -hl temp/hashlink/03_func_sum.hl
// run: hl temp/hashlink/03_func_sum.hl
// note: Haxe has no no-inline attribute at all — its metadata list has no NoInline entry, and
//       Haxe only inlines functions the programmer marked `inline`, so there is nothing on the
//       Haxe side to switch off. The helper lives in its own module, AddOne.hx, for the same
//       reason the hxcpp row does it: it keeps the helper out of the caller's module.
// note: unlike the hxcpp row there is no second compiler to worry about here. `haxe -hl` emits
//       HashLink bytecode, hl.exe has no JIT, and the VM performs no inlining of any kind, so
//       the hundred million calls are hundred million bytecode calls either way. The separate
//       module is kept so this row and the hxcpp row read the same.

class T03_func_sum {
    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
        var value = 0;

        for (i in 0...100000000) {
            value = AddOne.add_one(value);
        }

        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(value);
    }
}
