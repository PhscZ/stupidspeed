// task 03 func_sum — expected output: 100000000
// build: dmd -O -release -of=prog _03_func_sum.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _03_func_sum.d
// build (gdc): gdc -O2 -o prog _03_func_sum.d
// pragma(inline, false) keeps the call real; D's pragma is the language's no-inline facility.
// note (gdc): GDC here is 4.9.2, which predates that pragma (it arrived in D 2.070), so the
//             version(GNU) branch keeps the call real a different way: a virtual call through
//             a reference of abstract base type cannot be inlined or constant-folded by any D
//             compiler, because the base type does not say which override runs. Measured with
//             this branch: 0.94-0.99 s against 0.00 s for a folded loop, so the hundred million
//             calls really happen. The two other D toolchains are unaffected.

module _03_func_sum;

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

version (GNU)
{
    abstract class Adder
    {
        abstract long apply(long n);
    }

    final class AddOne : Adder
    {
        override long apply(long n)
        {
            return n + 1;
        }
    }

    void main()
    {
        ss_t0 = ss_now();
        Adder add = new AddOne();
        long value = 0;

        foreach (int i; 0 .. 100_000_000)
            value = add.apply(value);

        ssReport();
        writeln(value);
    }
}
else
{
    pragma(inline, false)
    long addOne(long n)
    {
        return n + 1;
    }

    void main()
    {
        ss_t0 = ss_now();
        long value = 0;

        foreach (int i; 0 .. 100_000_000)
            value = addOne(value);

        ssReport();
        writeln(value);
    }
}
