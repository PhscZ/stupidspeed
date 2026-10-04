// task 05 alloc_churn — expected output: 1274991808
// build: haxe -cp sources/hashlink -main T05_alloc_churn -hl temp/hashlink/05_alloc_churn.hl
// run: hl temp/hashlink/05_alloc_churn.hl
// note: `haxe.io.Bytes.alloc(64)` is the 64-byte heap allocation this task wants, and the
//       `slots` array keeps the newest 256 of them reachable. Haxe is garbage collected and
//       has no free, so the buffer a slot replaces is simply dropped and the collector
//       reclaims it, where the C row calls free() on it.
// note: this is the memory-pressure cell for HashLink's generational mark-and-sweep collector:
//       ten million 64-byte buffers are allocated and all but 256 become garbage.

class T05_alloc_churn {
    static function main() {
        // timing: Sys.time() is seconds as a Float on HashLink, so x1000 gives ms (1 ms effective).
        var t0 = Sys.time();
        var slots = new Array<haxe.io.Bytes>();
        for (i in 0...256) {
            slots.push(null);
        }

        var total = 0;
        for (i in 0...10000000) {
            var buf = haxe.io.Bytes.alloc(64);
            buf.set(0, i % 256);
            total += buf.get(0);

            slots[i % 256] = buf;
        }

        var t1 = Sys.time();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(total);
    }
}
