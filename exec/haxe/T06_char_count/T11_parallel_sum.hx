// task 11 parallel_sum — expected output: 7500000075000000
// build: haxe -cp sources/haxe -main T11_parallel_sum -cpp temp/haxe/11_parallel_sum -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/11_parallel_sum/T11_parallel_sum.exe
// note: real OS threads. `sys.thread.Thread.create` on cpp binds to hxcpp's hx::thread::Thread,
//       which is CreateThread(NULL, 0, func, param, 0, 0) on Windows, so the four workers run
//       on four cores. Join is `sys.thread.Lock`: one release per worker, one wait per worker.
// note: each worker owns a fixed quarter and writes its own slot of the jobs array, so which
//       one finishes first cannot change the answer. The workers allocate nothing, so hxcpp's
//       conservative stop-the-world collector has nothing to stall on.

class Job {
    public var t:Int;
    public var acc:haxe.Int64;

    public function new(t:Int) {
        this.t = t;
        acc = haxe.Int64.ofInt(0);
    }
}

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

    static function main() {
        #if js
        // js note: the js target has no sys.thread, so the four workers are node
        // worker_threads that run this very file again (__filename), with workerData.t saying
        // which quarter to compute. A worker publishes its haxe.Int64 as its two 32-bit words
        // into a SharedArrayBuffer (shared by reference, exact, no float rounding) and counts
        // itself out in word 0 with Atomics.add; the main thread's Atomics.wait on that word
        // is the join. `isMainThread` is the fork in the road: a worker never prints.
        var wt = js.Syntax.code("require('worker_threads')");
        if (wt.isMainThread == false) {
            var wd = wt.workerData;
            var acc = work_range(wd.t);
            var w32:js.lib.Int32Array = js.Syntax.code("new Int32Array({0})", wd.sab);
            w32[1 + wd.t * 2] = acc.low;
            w32[2 + wd.t * 2] = acc.high;
            js.Syntax.code("Atomics.add({0}, 0, 1)", w32);
            js.Syntax.code("Atomics.notify({0}, 0)", w32);
            return;
        }
        #end

        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        #if js
        var sab = js.Syntax.code("new SharedArrayBuffer({0})", (1 + THREADS * 2) * 4);
        var w32:js.lib.Int32Array = js.Syntax.code("new Int32Array({0})", sab);
        // The options object is a Haxe anonymous object rather than text inside the code
        // string: js.Syntax.code treats `{..}` as its own placeholder syntax.
        var workers = new Array<Dynamic>();
        for (t in 0...THREADS) {
            workers.push(js.Syntax.code("new (require('worker_threads').Worker)(__filename, {0})", { workerData: { t: t, sab: sab } }));
        }
        var joined = 0;
        while (joined < THREADS) {
            js.Syntax.code("Atomics.wait({0}, 0, {1}, 1000)", w32, joined);
            joined = w32[0];
        }
        if (workers.length != THREADS) {
            throw "worker_threads: expected " + THREADS + " workers";
        }
        var total = haxe.Int64.ofInt(0);
        for (t in 0...THREADS) {
            total += haxe.Int64.make(w32[2 + t * 2], w32[1 + t * 2]);
        }
        #else
        var jobs = new Array<Job>();
        for (t in 0...THREADS) {
            jobs.push(new Job(t));
        }

        var lock = new sys.thread.Lock();

        for (t in 0...THREADS) {
            var idx = t;
            sys.thread.Thread.create(function() {
                jobs[idx].acc = work_range(idx);
                lock.release();
            });
        }
        for (t in 0...THREADS) {
            lock.wait();
        }

        var total = haxe.Int64.ofInt(0);
        for (t in 0...THREADS) {
            total += jobs[t].acc;
        }
        #end

        var t1 = haxe.Timer.stamp();
        Out.err("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Out.line(total);
    }
}
