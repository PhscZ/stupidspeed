// task 11 parallel_sum — expected output: 7500000075000000
// build: none (interpreted)    run: qjs.exe --std 11_parallel_sum.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: QuickJS itself has no threads, but QuickJS-ng ships os.Worker, which starts a
//       real OS thread with its own interpreter, heap and module loader. Four workers are
//       started over task 02's range (t*25,000,000 .. (t+1)*25,000,000-1) and their
//       partial sums are added back on the main thread — four cores, same answer as task
//       02. The worker program is this same file: when os.Worker.parent is defined the
//       file runs as a worker instead of as the main program. Each worker owns a fixed
//       range, so scheduling cannot change the result. The partials and the total are
//       ordinary numbers below 2^53, so the checksum is exact.
//       `workers` is declared at module scope on purpose: QuickJS is reference-counted,
//       so a Worker held only by a block-scoped binding is collected the moment the block
//       ends, before it can reply. Holding the handles here keeps all four alive.

import * as os from "qjs:os";
import * as std from "qjs:std";

// The clock starts at the first statement of the main body, as the spec requires.
const __t0 = performance.now();

const CHUNK = 25000000;

// Module-scope, not block-scope: see the note above.
const workers = [];

function work(t) {
    let acc = 0;
    const first = t * CHUNK;
    const last = first + CHUNK;
    for (let i = first; i < last; i++) {
        switch (i % 4) {
            case 0:
                acc += 1;
                break;
            case 1:
                acc += i;
                break;
            case 2:
                acc += 2 * i;
                break;
            default:
                acc += 3 * i;
                break;
        }
    }
    return acc;
}

if (typeof os.Worker.parent !== "undefined") {
    // Worker half: answer the range index the parent sends.
    const parent = os.Worker.parent;
    parent.onmessage = (e) => {
        parent.postMessage(work(e.data));
    };
} else {
    // Main half: four workers, one range each.
    // os.Worker resolves its argument against the interpreter's cwd, not the script's
    // directory, so the script's own absolute path is passed explicitly.
    let self = import.meta.url;
    if (self.startsWith("file://")) {
        self = self.slice(7);
    }
    self = os.realpath(self)[0];

    let pending = 4;
    let total = 0;

    for (let t = 0; t < 4; t++) {
        const w = new os.Worker(self);
        workers.push(w);
        w.onmessage = (e) => {
            total += e.data;
            if (--pending === 0) {
                const __t1 = performance.now();
                std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
                std.out.puts(total + "\n");
                std.exit(0);      // workers would otherwise keep the process alive
            }
        };
        w.postMessage(t);
    }
}
