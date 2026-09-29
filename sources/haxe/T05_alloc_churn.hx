// task 05 alloc_churn — expected output: 1274991808
// build: haxe -cp sources/haxe -main T05_alloc_churn -cpp temp/haxe/05_alloc_churn -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/05_alloc_churn/T05_alloc_churn.exe
// note: `haxe.io.Bytes.alloc(64)` is the 64-byte heap allocation this task wants, and the
//       `slots` array keeps the newest 256 of them reachable. Haxe is garbage collected and
//       has no free, so the buffer a slot replaces is simply dropped and the collector
//       reclaims it, where the C row calls free() on it.
// note: this is the memory-pressure cell for hxcpp's conservative stop-the-world collector:
//       ten million 64-byte buffers are allocated and all but 256 become garbage.

class T05_alloc_churn {
    static function main() {
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

        Sys.println(total);
    }
}
