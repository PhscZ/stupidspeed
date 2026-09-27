// task 05 alloc_churn — expected output: 1274991808
// build: valac -X -O2 -o prog 05_alloc_churn.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: Vala has no garbage collector, so this is the C shape of the task: GLib.malloc for the
//       64-byte buffer and GLib.free for the buffer the slot replaces. The slots array is what
//       keeps the newest 256 buffers reachable and stops -O2 deleting the allocation, exactly
//       as in the C reference. `uint8*[]` is Vala's array of raw pointers.

int main () {
    uint8*[] slots = new uint8*[256];
    for (int i = 0; i < 256; i++) {
        slots[i] = null;
    }

    int64 total = 0;
    for (int64 i = 0; i < 10000000; i++) {
        uint8* buf = (uint8*) GLib.malloc (64);
        buf[0] = (uint8) (i % 256);
        total += (int64) buf[0];

        int slot = (int) (i % 256);
        GLib.free (slots[slot]);   /* the buffer this slot replaces is released here */
        slots[slot] = buf;         /* keeping buf reachable stops -O2 deleting it */
    }

    for (int i = 0; i < 256; i++) {
        GLib.free (slots[i]);
    }

    stdout.printf ("%lld\n", total);
    return 0;
}
