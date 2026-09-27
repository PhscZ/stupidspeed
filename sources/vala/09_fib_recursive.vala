// task 09 fib_recursive — expected output: 102334155
// build: valac -X -O2 -o prog 09_fib_recursive.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: this task calls no GLib function, so the linker drops the GLib import and the built
//       executable needs nothing at run time.
// note: plain double recursion, no memoisation; fib(40) is about 331 million calls. The
//       result needs more than 32 bits, so it is `int64`.

int64 fib (int64 n) {
    if (n < 2) {
        return n;
    }
    return fib (n - 1) + fib (n - 2);
}

int main () {
    stdout.printf ("%lld\n", fib (40));
    return 0;
}
