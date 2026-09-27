// task 04 array_sum — expected output: 499999500000
// build: valac -X -O2 -o prog 04_array_sum.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: `new int64[n]` is a plain g_malloc'd block of 64-bit elements, so the two loops walk
//       contiguous memory exactly like the C reference. The sum needs more than 32 bits.

int main () {
    int64 n = 1000000;
    int64[] array = new int64[n];

    for (int64 i = 0; i < n; i++) {
        array[i] = i;
    }

    int64 total = 0;
    for (int64 i = 0; i < n; i++) {
        total += array[i];
    }

    stdout.printf ("%lld\n", total);
    return 0;
}
