// task 02 switch_case — expected output: 7500000075000000
// build: haxe -cp sources/hashlink -main T02_switch_case -hl temp/hashlink/02_switch_case.hl
// run: hl temp/hashlink/02_switch_case.hl
// note: the total is 7.5e15, past 2^31, so a plain Int accumulator would wrap and print a
//       wrong number. It is an haxe.Int64. On HashLink 1.12 and later `hl.I64` — which is what
//       haxe.Int64 is an abstract over — is a `@:coreType @:runtimeValue`, i.e. a real unboxed
//       64-bit value in a VM register, not a pair of 32-bit halves, so the switch stays a
//       machine add.

class T02_switch_case {
    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
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

        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(acc);
    }
}
