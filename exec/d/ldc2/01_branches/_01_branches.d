// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: dmd -O -release -of=prog _01_branches.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _01_branches.d

module _01_branches;

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
    long a = 0, b = 0, c = 0, d = 0;

    foreach (int i; 0 .. 100_000_000)
    {
        if (i % 3 == 0)
            a += 1;
        else if (i % 5 == 0)
            b += 1;
        else if (i % 7 == 0)
            c += 1;
        else
            d += 1;
    }

    ssReport();
    writeln(a, " ", b, " ", c, " ", d);
}
