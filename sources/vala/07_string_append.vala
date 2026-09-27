// task 07 string_append — expected output: 1000000
// build: valac -X -O2 -o prog 07_string_append.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: a Vala `string` is a C `char *`, immutable, and `text + "x"` is g_strconcat: it walks
//       the old string, allocates a fresh one and copies both parts, so the loop is quadratic
//       on purpose, exactly like the C reference. `.length` is the byte length.
// note: this is the slow one of the row — a million quadratic appends take about fifteen
//       minutes, the same order as the Java and Groovy rows' task 07.

int main () {
    string text = "";

    for (int64 i = 0; i < 1000000; i++) {
        text = text + "x";
    }

    stdout.printf ("%d\n", text.length);
    return 0;
}
