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

        Sys.println(total);
    }
}
