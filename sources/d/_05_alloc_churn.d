// task 05 alloc_churn — expected output: 1274991808
// build: dmd -O -release -of=prog _05_alloc_churn.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _05_alloc_churn.d

module _05_alloc_churn;

import std.stdio;
import core.time : MonoTime;
alias ss_clock_t = MonoTime;
ss_clock_t ss_now() { return MonoTime.currTime; }
double ss_elapsed_ms(ss_clock_t t0) { return (MonoTime.currTime - t0).total!"usecs" / 1000.0; }


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
    long total = 0;
    ubyte[][] slots = new ubyte[][256];

    foreach (int i; 0 .. 10_000_000)
    {
        ubyte[] buf = new ubyte[64];
        buf[0] = cast(ubyte)(i % 256);
        total += buf[0];
        slots[i % 256] = buf; // keeps buf reachable; the replaced one becomes GC garbage
    }

    ssReport();
    writeln(total);
}
