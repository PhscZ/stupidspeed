// task 08 average — expected output: 0.498046875
// build: dmd -O -release -of=prog _08_average.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _08_average.d

module _08_average;

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
    double total = 0.0;

    foreach (int i; 0 .. 100_000_000)
    {
        double reading = (i % 256) / 256.0;
        total += reading;
    }

    ssReport();
    writefln("%.9f", total / 100_000_000);
}
