// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: dmd -O -release -of=prog _01_branches.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _01_branches.d

module _01_branches;

import std.stdio;

void main()
{
    long a = 0, b = 0, c = 0, d = 0;

    foreach (int i; 0 .. 100_000_000)
    {
        if (i % 3 == 0)
            a += 1;
        else if (i % 5 == 0)
            b += 1;
        else if (i % 7 == 0)
            c += 1;
        else
            d += 1;
    }

    writeln(a, " ", b, " ", c, " ", d);
}
