// task 15 file_write — expected output: 52428800
// build: valac -X -O2 -o prog 15_file_write.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: one 1 MiB buffer of the bytes 0..255 repeating, written 50 times through
//       GLib.FileStream (a FILE*, so `write` is fwrite), then flushed and fsynced.
//       GLib.FileUtils.fsync is g_fsync, which on Windows is _commit, so no libc call has to
//       be declared by hand. The stream is closed by Vala when it goes out of scope.

int main () {
    int64 chunk = 1048576;

    uint8[] buf = new uint8[chunk];
    for (int64 i = 0; i < chunk; i++) {
        buf[i] = (uint8) (i % 256);
    }

    var fs = GLib.FileStream.open ("out.bin", "wb");
    if (fs == null) {
        stderr.printf ("cannot open out.bin\n");
        return 1;
    }

    int64 written = 0;
    for (int i = 0; i < 50; i++) {
        written += (int64) fs.write (buf);
    }

    fs.flush ();
    GLib.FileUtils.fsync (fs.fileno ());

    stdout.printf ("%lld\n", written);
    return 0;
}
