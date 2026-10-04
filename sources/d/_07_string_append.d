// task 07 string_append — expected output: 250000
// build: dmd -O -release -of=prog _07_string_append.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _07_string_append.d
// Plain string concatenation: each assignment allocates and copies the whole string.

module _07_string_append;

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
    string text = "";

    foreach (int i; 0 .. 250_000)
        text = text ~ "x";

    ssReport();
    writeln(text.length);
}
