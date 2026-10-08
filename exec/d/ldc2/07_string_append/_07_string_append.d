// task 07 string_append — expected output: 250000
// build: dmd -O -release -of=prog _07_string_append.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _07_string_append.d
// Plain string concatenation: each assignment allocates and copies the whole string.

module _07_string_append;

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
    string text = "";

    foreach (int i; 0 .. 250_000)
        text = text ~ "x";

    ssReport();
    writeln(text.length);
}
