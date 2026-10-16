// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: pike 08_average.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
//
// The accumulator is Gmp.mpf, Pike's arbitrary-precision float, not the machine `float`.
//
// This build's own `float` is IEEE binary32.  Pike-v8.0.1956-Windows-x86.info says
//   float type.......... float (4 bytes) (ieee little endian)
// and no wider machine float is reachable from the language: `indices(Pike)` has no member
// with "float" or "double" in its name at all, and `Pike.FLOAT_TYPE` /
// `Pike.DOUBLE_PRECISION` do not exist as symbols (both are compile-time errors).  A
// binary32 accumulator saturates: summing these readings it reaches 2^24 and then stops
// moving, because 1 ULP at 2^24 is 2.0, and the program would print 0.167772159.
//
// Choosing a wider accumulator type is a language-level decision, not a different algorithm
// -- it is what every other row here does implicitly by having a 64-bit `double`.  Pike's
// route to the same thing is Gmp.mpf: set its precision once and accumulate exactly.  The
// loop, the reading expression and the order of the additions are unchanged; only the
// accumulator's type is wider.  The exact sum is 99609375, whose significand needs 27 bits,
// so the 128-bit precision set below is exact with a wide margin.
//
// The final average is 99609375 / 200000000 = 255/512, a multiple of 2^-9, so multiplying
// it by 10^9 gives the exact integer 498046875 and the digits can be rendered from the exact
// value with no machine float involved anywhere in the program.  (This is necessary rather
// than merely tidy: `sprintf("%.9f", some_mpf)` does not use the row's format at all -- it
// goes through GMP's own notation, printing .5 for one half and 5.e1 for fifty.)

int main() {
    int __t0 = gethrtime(1);
    Gmp.mpf total = Gmp.mpf(0);
    total->set_precision(128);

    for (int i = 0; i < 200000000; i++) {
        float reading = (i % 256) / 256.0;
        total = total + reading;
    }

    Gmp.mpf average = total / 200000000;
    Gmp.mpz scaled = (average * 1000000000)->get_int();

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d.%09d\n", scaled / 1000000000, scaled % 1000000000);
    return 0;
}
