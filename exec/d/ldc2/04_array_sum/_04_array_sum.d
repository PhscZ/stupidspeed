// task 04 array_sum — expected output: 499999500000
// build: dmd -O -release -of=prog _04_array_sum.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _04_array_sum.d

module _04_array_sum;

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
    long[] array = new long[1_000_000];

    foreach (int i; 0 .. 1_000_000)
        array[i] = i;

    long total = 0;
    foreach (int i; 0 .. 1_000_000)
        total += array[i];

    ssReport();
    writeln(total);
}
