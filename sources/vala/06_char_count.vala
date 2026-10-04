// task 06 char_count — expected output: 10000000
// build: valac -X -O2 -o prog 06_char_count.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: the whole 100 MB text is built up front by copying the ten-character block into every
//       tenth slot, the same way the C reference does it; nothing is appended in a loop. The
//       scan then walks the buffer one byte at a time.

// timing: GLib.get_real_time() is GLib's monotonic clock in microseconds; TIME_MS goes
//         to stderr and stdout is unchanged.
static int64 ss_t0;
static void ss_report () {
    stderr.printf ("TIME_MS=%.3f\n", (GLib.get_real_time () - ss_t0) / 1000.0);
}

int main () {
    ss_t0 = GLib.get_real_time ();
    int64 repeats = 10000000;
    int64 block_len = 10;
    int64 text_len = repeats * block_len;

    uint8[] text = new uint8[text_len];

    for (int64 i = 0; i < repeats; i++) {
        Memory.copy (&text[i * block_len], "abcdefghij", (size_t) block_len);
    }

    int64 count = 0;
    for (int64 i = 0; i < text_len; i++) {
        if (text[i] == 'a') {
            continue;
        } else if (text[i] == 'e') {
            continue;
        } else if (text[i] == 'h') {
            count += 1;
        }
    }

    ss_report ();
    stdout.printf ("%lld\n", count);
    return 0;
}
