// task 02 switch_case — expected output: 7500000075000000
// build: haxe -cp sources/haxe -main T02_switch_case -cpp temp/haxe/02_switch_case -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/02_switch_case/T02_switch_case.exe
// note: the total is 7.5e15, past 2^31, so the accumulator is haxe.Int64. On cpp that is a
//       native 64-bit integer, not a boxed object, so the switch stays a machine add.

class T02_switch_case {
    static function main() {
        var acc = haxe.Int64.ofInt(0);

        for (i in 0...100000000) {
            switch (i % 4) {
                case 0:
                    acc += 1;
                case 1:
                    acc += i;
                case 2:
                    acc += 2 * i;
                case 3:
                    acc += 3 * i;
            }
        }

        Sys.println(acc);
    }
}
