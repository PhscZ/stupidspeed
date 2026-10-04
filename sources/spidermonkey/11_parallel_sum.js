// task 11 parallel_sum — expected output: 7500000075000000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 11_parallel_sum.js
// note: four real OS threads via evalInWorker, sharing one SharedArrayBuffer that carries the four
//       Float64 partials plus four Int32 done-flags. The partials sum to 7.5e15, below 2^53, so
//       doubles hold them exactly.

var __t0 = performance.now();
var N = 4;
var CHUNK = 25000000;
var FLOATS = 8 * N;                              /* N Float64 partials */
var sab = new SharedArrayBuffer(FLOATS + 4 * N); /* + N Int32 done-flags */
setSharedArrayBuffer(sab);

var partials = new Float64Array(sab, 0, N);
var flags = new Int32Array(sab, FLOATS, N);

for (var t = 0; t < N; t++) {
  evalInWorker(`
    var sab = getSharedArrayBuffer();
    var partials = new Float64Array(sab, 0, ${N});
    var flags = new Int32Array(sab, ${FLOATS}, ${N});
    var idx = ${t};
    var lo = idx * ${CHUNK};
    var hi = lo + ${CHUNK};
    var acc = 0;
    for (var i = lo; i < hi; i++) {
      switch (i % 4) {
        case 0: acc += 1; break;
        case 1: acc += i; break;
        case 2: acc += 2 * i; break;
        case 3: acc += 3 * i; break;
      }
    }
    partials[idx] = acc;
    Atomics.store(flags, idx, 1);
  `);
}

for (var t = 0; t < N; t++) {
  while (Atomics.load(flags, t) === 0) {
    /* spin until the worker publishes its partial */
  }
}

var total = 0;
for (var t = 0; t < N; t++) {
  total += partials[t];
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(total);
