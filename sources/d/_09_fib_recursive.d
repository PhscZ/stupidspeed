// task 09 fib_recursive — expected output: 102334155
// build: dmd -O -release -of=prog _09_fib_recursive.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _09_fib_recursive.d

module _09_fib_recursive;

import std.stdio;

long fib(long n)
{
    if (n < 2)
        return n;
    return fib(n - 1) + fib(n - 2);
}

void main()
{
    writeln(fib(40));
}
