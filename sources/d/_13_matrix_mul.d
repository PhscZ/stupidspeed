// task 13 matrix_mul — expected output: 599995000
// build: dmd -O -release -of=prog _13_matrix_mul.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _13_matrix_mul.d

module _13_matrix_mul;

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
    const int n = 500;

    long[] a = new long[n * n];
    long[] b = new long[n * n];
    long[] c = new long[n * n];

    foreach (int i; 0 .. n)
    {
        foreach (int j; 0 .. n)
        {
            a[i * n + j] = (i + j) % 7;
            b[i * n + j] = (i * j) % 5;
        }
    }

    foreach (int i; 0 .. n)
    {
        foreach (int j; 0 .. n)
        {
            long sum = 0;
            foreach (int k; 0 .. n)
            {
                sum += a[i * n + k] * b[k * n + j];
            }
            c[i * n + j] = sum;
        }
    }

    long total = 0;
    foreach (int x; 0 .. n * n)
        total += c[x];

    ssReport();
    writeln(total);
}
