// task 11 parallel_sum — expected output: 7500000075000000
// build: valac -X -O2 -o prog 11_parallel_sum.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: GLib.Thread is GLib's own thread class — four real OS threads on Windows, one fixed
//       25000000-wide range each, so which thread finishes first cannot change the answer.
//       `join()` returns the lambda's value, hence the `int64?` thread type. GLib's thread
//       code lives in libgthread, which GLib 2.32 and later merged into libglib, so no
//       extra --pkg is needed.

int64 work (int64 t) {
    int64 acc = 0;
    int64 lo = t * 25000000;
    int64 hi = lo + 25000000;

    for (int64 i = lo; i < hi; i++) {
        switch (i % 4) {
            case 0: acc += 1; break;
            case 1: acc += i; break;
            case 2: acc += 2 * i; break;
            case 3: acc += 3 * i; break;
        }
    }
    return acc;
}

int main () {
    GLib.Thread<int64?>[] th = new GLib.Thread<int64?>[4];

    for (int t = 0; t < 4; t++) {
        int tt = t;
        th[t] = new GLib.Thread<int64?> (null, () => { return work (tt); });
    }

    int64 total = 0;
    for (int t = 0; t < 4; t++) {
        total += th[t].join ();
    }

    stdout.printf ("%lld\n", total);
    return 0;
}
