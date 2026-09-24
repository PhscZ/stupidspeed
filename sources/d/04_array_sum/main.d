// task 04 array_sum — expected output: 499999500000
// build: dmd -O -release -of=prog main.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog main.d

module main;

import std.stdio;

void main()
{
    long[] array = new long[1_000_000];

    foreach (int i; 0 .. 1_000_000)
        array[i] = i;

    long total = 0;
    foreach (int i; 0 .. 1_000_000)
        total += array[i];

    writeln(total);
}
