// task 15 file_write — expected output: 52428800
// build: dmd -O -release -of=prog _15_file_write.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _15_file_write.d
// std.stdio.File exposes flush() but no portable fsync, so flush() is the closest equivalent.

module _15_file_write;

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
    ubyte[] buf = new ubyte[1024 * 1024];
    foreach (size_t i; 0 .. buf.length)
        buf[i] = cast(ubyte)(i % 256);

    auto file = File("out.bin", "wb");

    ulong written = 0;
    foreach (int rep; 0 .. 50)
    {
        file.rawWrite(buf);
        written += buf.length;
    }
    file.flush();

    ssReport();
    writeln(written);
}
