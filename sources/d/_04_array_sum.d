// task 04 array_sum — expected output: 499999500000
// build: dmd -O -release -of=prog _04_array_sum.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _04_array_sum.d

module _04_array_sum;

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
