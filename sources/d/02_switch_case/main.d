// task 02 switch_case — expected output: 7500000075000000
// build: dmd -O -release -of=prog main.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog main.d

module main;

import std.stdio;

void main()
{
    long acc = 0;

    foreach (int i; 0 .. 100_000_000)
    {
        switch (i % 4)
        {
            case 0:
                acc += 1;
                break;
            case 1:
                acc += i;
                break;
            case 2:
                acc += 2L * i;
                break;
            case 3:
                acc += 3L * i;
                break;
        }
    }

    writeln(acc);
}
