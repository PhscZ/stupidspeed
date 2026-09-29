// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: cscript //nologo //E:JScript 09_fib_recursive.js
// note: fib(40) is about 331 million calls and measures 89 s to 327 s on this shared host,
//       about 0.27 us to 1.0 us a call (fastest 88.8 s, slowest 326.6 s). The smaller sizes
//       used to check the recursion are fib(25) 73 ms and fib(30) 586 ms, a factor of 8.0
//       per five levels -- the golden ratio to the fifth -- which extrapolates to about
//       72 s, so a call gets a little dearer at the larger sizes.
// note: the recursion really happens -- there is no tail call here and the engine does
//       not turn the double call into a loop.
// note: the result, 102334155, is far below 2^53, so the additions are exact.
function fib(n) {
    if (n < 2) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

WScript.Echo(String(fib(40)));
