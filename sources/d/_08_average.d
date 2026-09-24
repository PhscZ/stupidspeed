// task 08 average — expected output: 0.498046875
// build: dmd -O -release -of=prog _08_average.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _08_average.d

module _08_average;

import std.stdio;

void main()
{
    double total = 0.0;

    foreach (int i; 0 .. 100_000_000)
    {
        double reading = (i % 256) / 256.0;
        total += reading;
    }

    writefln("%.9f", total / 100_000_000);
}
