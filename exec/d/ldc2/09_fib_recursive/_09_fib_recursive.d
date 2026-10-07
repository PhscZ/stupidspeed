// task 09 fib_recursive — expected output: 102334155
// build: dmd -O -release -of=prog _09_fib_recursive.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _09_fib_recursive.d

module _09_fib_recursive;

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

long fib(long n)
{
    if (n < 2)
        return n;
    return fib(n - 1) + fib(n - 2);
}

void main()
{
    ss_t0 = ss_now();
    long ss_r = fib(40);
    ssReport();
    writeln(ss_r);
}
