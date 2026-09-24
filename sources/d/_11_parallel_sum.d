// task 11 parallel_sum — expected output: 7500000075000000
// build: dmd -O -release -of=prog _11_parallel_sum.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _11_parallel_sum.d

module _11_parallel_sum;

import std.stdio;
import core.thread;

long work(long t)
{
    long acc = 0;
    long lo = t * 25_000_000L;
    long hi = lo + 25_000_000L;

    for (long i = lo; i < hi; ++i)
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
                acc += 2 * i;
                break;
            case 3:
                acc += 3 * i;
                break;
        }
    }

    return acc;
}

class Worker : Thread
{
    private long id;
    long result;

    this(long id)
    {
        super(&run);
        this.id = id;
    }

    private void run()
    {
        result = work(id);
    }
}

void main()
{
    Worker[4] workers;

    foreach (int t; 0 .. 4)
        workers[t] = new Worker(t);

    foreach (ref w; workers)
        w.start();

    thread_joinAll();

    long total = 0;
    foreach (ref w; workers)
        total += w.result;

    writeln(total);
}
