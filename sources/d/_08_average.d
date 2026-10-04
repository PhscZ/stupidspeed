// task 08 average — expected output: 0.498046875
// build: dmd -O -release -of=prog _08_average.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _08_average.d

module _08_average;

import std.stdio;
import core.time : MonoTime;

// timing: MonoTime.currTime is core.time's monotonic clock; TIME_MS goes to stderr and stdout
// is unchanged.
MonoTime ss_t0;

void ssReport()
{
    stderr.writefln("TIME_MS=%.3f", (MonoTime.currTime - ss_t0).total!"usecs" / 1000.0);
}

void main()
{
    ss_t0 = MonoTime.currTime;
    double total = 0.0;

    foreach (int i; 0 .. 100_000_000)
    {
        double reading = (i % 256) / 256.0;
        total += reading;
    }

    ssReport();
    writefln("%.9f", total / 100_000_000);
}
