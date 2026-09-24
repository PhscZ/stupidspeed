// task 12 matrix_add — expected output: 999000000
// build: dmd -O -release -of=prog main.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog main.d

module main;

import std.stdio;

void main()
{
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

    writeln(total);
}
