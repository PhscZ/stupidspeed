// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: valac -X -O2 -o prog 01_branches.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: this task calls no GLib function, so the linker drops the GLib import and the built
//       executable needs nothing at run time.
// note: Vala's `int` is 32 bits, so the loop index and the four counters are `int64`.

int main () {
    int64 a = 0;
    int64 b = 0;
    int64 c = 0;
    int64 d = 0;

    for (int64 i = 0; i < 100000000; i++) {
        if (i % 3 == 0) {
            a += 1;
        } else if (i % 5 == 0) {
            b += 1;
        } else if (i % 7 == 0) {
            c += 1;
        } else {
            d += 1;
        }
    }

    stdout.printf ("%lld %lld %lld %lld\n", a, b, c, d);
    return 0;
}
