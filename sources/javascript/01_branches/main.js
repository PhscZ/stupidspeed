// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none    run: node main.js | bun main.js | deno run main.js

let a = 0;
let b = 0;
let c = 0;
let d = 0;
for (let i = 0; i < 100000000; i++) {
  if (i % 3 === 0) {
    a += 1;
  } else if (i % 5 === 0) {
    b += 1;
  } else if (i % 7 === 0) {
    c += 1;
  } else {
    d += 1;
  }
}
console.log(a, b, c, d);
