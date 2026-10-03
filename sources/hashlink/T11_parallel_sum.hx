// task 11 parallel_sum — expected output: 7500000075000000
// build: haxe -cp sources/hashlink -main T11_parallel_sum -hl temp/hashlink/11_parallel_sum.hl
// run: hl temp/hashlink/11_parallel_sum.hl          (with `hl.exe` on PATH)
// note: deviation — HashLink has no thread API to use. `sys.thread` does not exist on this
//       target (`Type.resolveClass("sys.thread.Thread")` is null), the std's only concurrency
//       surface is hl.Atomics, and the bundled libuv bindings (hl.uv) ship Fs/Loop/Stream/Tcp
//       and no uv_thread_create. So the four workers are four child `hl` processes, which is
//       what the VBScript, COBOL, Octave and gforth rows do for the same reason.
// note: each worker still owns t*25000000..(t+1)*25000000-1 and nothing else, so which one
//       finishes first cannot change the answer. The parent starts all four before waiting on
//       any of them, so the four quarters really do run at once — measured on this machine, a
//       single worker over its quarter takes 0.29s while all four together over the whole
//       100000000 take 0.32s (against 1.20s for the same work in one process), i.e. 4x the
//       work for 1.1x the wall time.
// note: the child hands its partial back through a file, not through its stdout pipe: reading
//       a child's stdout under HashLink throws Eof. Each child writes
//       <cwd>/hashlink_t11_part_<t>.txt, the parent waits for exitCode() and reads it back,
//       then deletes it, so nothing is left behind.
// note: `Sys.programPath()` is the .hl file being run, which is what the children are told to
//       run; the child recognises itself by the argument it was handed.

class T11_parallel_sum {
    static inline var THREADS = 4;
    static inline var SPAN = 25000000;

    static function work_range(t:Int):haxe.Int64 {
        var acc = haxe.Int64.ofInt(0);
        var lo = t * SPAN;
        var hi = lo + SPAN;

        for (i in lo...hi) {
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
        return acc;
    }

    static function part_path(t:Int):String {
        return Sys.getCwd() + "hashlink_t11_part_" + t + ".txt";
    }

    static function main() {
        var args = Sys.args();
        if (args.length > 0) {
            var t = Std.parseInt(args[0]);
            sys.io.File.saveContent(part_path(t), haxe.Int64.toStr(work_range(t)));
            return;
        }

        var self = Sys.programPath();
        var workers = new Array<sys.io.Process>();
        for (t in 0...THREADS) {
            workers.push(new sys.io.Process("hl.exe", [self, Std.string(t)]));
        }

        var total = haxe.Int64.ofInt(0);
        for (t in 0...THREADS) {
            workers[t].exitCode();
            workers[t].close();

            var path = part_path(t);
            total += haxe.Int64.parseString(StringTools.trim(sys.io.File.getContent(path)));
            sys.FileSystem.deleteFile(path);
        }

        Sys.println(total);
    }
}
