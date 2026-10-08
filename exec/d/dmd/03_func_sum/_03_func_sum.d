// task 03 func_sum — expected output: 100000000
// build: dmd -O -release -of=prog _03_func_sum.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _03_func_sum.d
// pragma(inline, false) keeps the call real; D's pragma is the language's no-inline facility.

module _03_func_sum;

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

