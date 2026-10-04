// task 09 fib_recursive — expected output: 102334155
// build: dmd -O -release -of=prog _09_fib_recursive.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _09_fib_recursive.d

module _09_fib_recursive;

import std.stdio;
import core.time : MonoTime;

// timing: MonoTime.currTime is core.time's monotonic clock; TIME_MS goes to stderr and stdout
// is unchanged.
MonoTime ss_t0;

void ssReport()
{
    stderr.writefln("TIME_MS=%.3f", (MonoTime.currTime - ss_t0).total!"usecs" / 1000.0);
}

long fib(long n)
{
    if (n < 2)
        return n;
    return fib(n - 1) + fib(n - 2);
}

void main()
{
    ss_t0 = MonoTime.currTime;
    long ss_r = fib(40);
    ssReport();
    writeln(ss_r);
}
