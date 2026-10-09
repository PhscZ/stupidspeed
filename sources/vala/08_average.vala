// task 08 average — expected output: 0.498046875
// build: valac -X -O2 -o prog 08_average.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: this task calls no GLib function, so the linker drops the GLib import and the built
//       executable needs nothing at run time.
// note: Vala's `double` is an IEEE 64-bit double, so the readings are the exact multiples of
//       1/256 the task asks for and the sum is exact. `%.9f` prints the nine digits the
//       expected output has.

// timing: GLib.get_real_time() is GLib's monotonic clock in microseconds; TIME_MS goes
//         to stderr and stdout is unchanged.
static int64 ss_t0;
static void ss_report () {
    stderr.printf ("TIME_MS=%.3f\n", (GLib.get_real_time () - ss_t0) / 1000.0);
}

int main () {
    ss_t0 = GLib.get_real_time ();
    double total = 0.0;

    for (int64 i = 0; i < 100000000; i++) {
        double reading = (double) (i % 256) / 256.0;
        total += reading;
    }

    ss_report ();
    stdout.printf ("%.9f\n", total / 100000000.0);
    return 0;
}
