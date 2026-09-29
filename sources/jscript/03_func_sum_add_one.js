// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: loaded by 03_func_sum.js, not run directly
// note: the helper is a separate file so that the call cannot be folded into its
//       caller. Windows Script Host JScript has no include directive, so 03_func_sum.js
//       reads this file in text mode and evals it; the file is pure ASCII, which is what
//       makes that safe.
function add_one(n) {
    return n + 1;
}
