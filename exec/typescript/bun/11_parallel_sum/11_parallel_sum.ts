// task 11 parallel_sum — expected output: 7500000075000000
// build: none    run: bun 11_parallel_sum.ts | deno run --allow-read 11_parallel_sum.ts
// note: four worker_threads, one heap each; the partials are doubles and the total is under 2^53.

const __t0: number = performance.now();

import { Worker, isMainThread, parentPort, workerData } from "node:worker_threads";

const CHUNK: number = 25000000;
const WORKERS: number = 4;

function work(t: number): number {
  let acc: number = 0;
  const start: number = t * CHUNK;
  const end: number = start + CHUNK;
  for (let i: number = start; i < end; i++) {
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
  const workers: Worker[] = [];
  for (let t: number = 0; t < WORKERS; t++) {
    workers.push(new Worker(new URL(import.meta.url), { workerData: t }));
  }

  let total: number = 0;
  let done: number = 0;
  for (const w of workers) {
    w.on("message", (partial: number) => {
      total += partial;
      done += 1;
      if (done === WORKERS) {
        console.error(`TIME_MS=${performance.now() - __t0}`);
        console.log(total);
      }
    });
  }
} else {
  parentPort!.postMessage(work(workerData as number));
}
