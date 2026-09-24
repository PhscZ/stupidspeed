// task 11 parallel_sum — expected output: 7500000075000000
// build: none    run: node 11_parallel_sum.js | bun 11_parallel_sum.js | deno run 11_parallel_sum.js
// note: four worker_threads, one heap each; the partials are doubles and the total is under 2^53.

const { Worker, isMainThread, parentPort, workerData } = require('node:worker_threads');

const CHUNK = 25000000;

function work(t) {
  let acc = 0;
  const start = t * CHUNK;
  const end = start + CHUNK;
  for (let i = start; i < end; i++) {
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
      case 3:
        acc += 3 * i;
        break;
    }
  }
  return acc;
}

if (isMainThread) {
  const workers = [];
  for (let t = 0; t < 4; t++) {
    workers.push(new Worker(__filename, { workerData: t }));
  }

  let total = 0;
  let done = 0;
  for (const w of workers) {
    w.on('message', (partial) => {
      total += partial;
      done += 1;
      if (done === 4) {
        console.log(total);
      }
    });
  }
} else {
  parentPort.postMessage(work(workerData));
}
