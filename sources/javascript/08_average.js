// task 08 average — expected output: 0.498046875
// build: none    run: node 08_average.js | bun 08_average.js | deno run 08_average.js

let total = 0.0;
for (let i = 0; i < 100000000; i++) {
  const reading = (i % 256) / 256.0;
  total += reading;
}
console.log(total / 100000000);
