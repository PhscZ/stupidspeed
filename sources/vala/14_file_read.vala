// task 14 file_read — expected output: 2389704704
// build: valac -X -O2 -o prog 14_file_read.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: data.bin is read from the current directory in 1 MiB chunks and every byte is added
//       up; the running total is reduced mod 2^32 only when it is printed. GLib.FileStream is
//       a FILE* — `read` is fread and the chunk length comes from the array's own length.

int main () {
    var fs = GLib.FileStream.open ("data.bin", "rb");
    if (fs == null) {
        stderr.printf ("cannot open data.bin\n");
        return 1;
    }

    uint8[] buf = new uint8[1048576];
    uint64 total = 0;
    size_t got;

    while ((got = fs.read (buf)) > 0) {
        for (size_t i = 0; i < got; i++) {
            total += (uint64) buf[i];
        }
    }

    stdout.printf ("%llu\n", (uint64) (total % 4294967296));
    return 0;
}
