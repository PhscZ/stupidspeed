// task 14 file_read — expected output: 2389704704
// build: dmd -O -release -of=prog _14_file_read.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _14_file_read.d

module _14_file_read;

import std.stdio;
version(GNU)
{
    // GDC 4.9.2 (D 2.066.1) predates MonoTime, so the monotonic clock is the older
    // TickDuration.currSystemTick; both branches expose ss_now/ss_elapsed_ms.
    import core.time : TickDuration;
    alias ss_clock_t = TickDuration;
    ss_clock_t ss_now() { return TickDuration.currSystemTick; }
    double ss_elapsed_ms(ss_clock_t t0) { return (TickDuration.currSystemTick - t0).usecs / 1000.0; }
}
else
{
    import core.time : MonoTime;
    alias ss_clock_t = MonoTime;
    ss_clock_t ss_now() { return MonoTime.currTime; }
    double ss_elapsed_ms(ss_clock_t t0) { return (MonoTime.currTime - t0).total!"usecs" / 1000.0; }
}

// timing: MonoTime.currTime is core.time's monotonic clock; TIME_MS goes to stderr and stdout
// is unchanged.
ss_clock_t ss_t0;

void ssReport()
{
    stderr.writefln("TIME_MS=%.3f", ss_elapsed_ms(ss_t0));
}

void main()
{
    ss_t0 = ss_now();
    auto file = File("data.bin", "rb");
    ubyte[] buf = new ubyte[1024 * 1024];

    ulong total = 0;
    for (;;)
    {
        size_t got = file.rawRead(buf).length;
        if (got == 0)
            break;
        foreach (ubyte b; buf[0 .. got])
            total += b;
    }

    ssReport();
    writeln(total % 4294967296UL);
}
