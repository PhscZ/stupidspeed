// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: haxe -cp sources/hashlink -main T01_branches -hl temp/hashlink/01_branches.hl
// run: hl temp/hashlink/01_branches.hl
// note: this row is the Haxe language on the HashLink bytecode VM (haxe -hl + hl.exe), not the
//       hxcpp native backend that sources/haxe/ uses; the source is the same Haxe either way,
//       only the build lines differ. Nothing here relies on native-only behaviour.
// note: Haxe's `Int` is 32 bits on every target, including this one, so the four counters are
//       plain Int; the largest of them, 45714285, fits with room to spare.
// note: Haxe ties a type name to its file name and a type name must start with an uppercase
//       letter, so `01_branches.hx` is not a legal module; every file in this directory is
//       named `T01_branches.hx`, class `T01_branches`, like the hxcpp row next door.

class T01_branches {
    static function main() {
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

        Sys.println('$a $b $c $d');
    }
}
