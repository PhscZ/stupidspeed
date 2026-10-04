// task 02 switch_case — expected output: 7500000075000000
// build: valac -X -O2 -o prog 02_switch_case.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: this task calls no GLib function, so the linker drops the GLib import and the built
//       executable needs nothing at run time.
// note: the total needs more than 32 bits, so the accumulator is `int64`; the loop index is
//       `int64` too, which is what keeps `i mod 4` from wrapping.

// timing: GLib.get_real_time() is GLib's monotonic clock in microseconds; TIME_MS goes
//         to stderr and stdout is unchanged.
static int64 ss_t0;
static void ss_report () {
    stderr.printf ("TIME_MS=%.3f\n", (GLib.get_real_time () - ss_t0) / 1000.0);
}

int main () {
    ss_t0 = GLib.get_real_time ();
    int64 acc = 0;

    for (int64 i = 0; i < 100000000; i++) {
        switch (i % 4) {
            case 0: acc += 1; break;
            case 1: acc += i; break;
            case 2: acc += 2 * i; break;
            case 3: acc += 3 * i; break;
        }
    }

    ss_report ();
    stdout.printf ("%lld\n", acc);
    return 0;
}
