// task 02 switch_case — expected output: 7500000075000000
// build: none    run: node 02_switch_case.js | bun 02_switch_case.js | deno run 02_switch_case.js

let acc = 0;
for (let i = 0; i < 100000000; i++) {
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
console.log(acc);
