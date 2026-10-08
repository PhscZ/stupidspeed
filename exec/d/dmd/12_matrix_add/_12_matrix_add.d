// task 12 matrix_add — expected output: 999000000
// build: dmd -O -release -of=prog _12_matrix_add.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _12_matrix_add.d

module _12_matrix_add;

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
    const int n = 1000;

    long[] a = new long[n * n];
    long[] b = new long[n * n];
    long[] c = new long[n * n];

    foreach (int i; 0 .. n)
    {
        foreach (int j; 0 .. n)
        {
            a[i * n + j] = i + j;
            b[i * n + j] = i - j;
        }
    }

    foreach (int i; 0 .. n)
    {
        foreach (int j; 0 .. n)
        {
            c[i * n + j] = a[i * n + j] + b[i * n + j];
        }
    }

    long total = 0;
    foreach (int x; 0 .. n * n)
        total += c[x];

    ssReport();
    writeln(total);
}
