// task 11 parallel_sum — expected output: 7500000075000000
// build: dmd -O -release -of=prog _11_parallel_sum.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _11_parallel_sum.d

module _11_parallel_sum;

import std.stdio;
import core.thread;
version(GNU)
{
    // GDC 4.9.2 (D 2.066.1) predates MonoTime, so the monotonic clock is the older
    // TickDuration.currSystemTick; both branches expose ss_now/ss_elapsed_ms.
    import core.time : TickDuration;
    alias ss_clock_t = TickDuration;
    ss_clock_t ss_now() { return TickDuration.currSystemTick; }
    double ss_elapsed_ms(ss_clock_t t0) { return (TickDuration.currSystemTick - t0).usecs / 1000.0; }
}
else
{
    import core.time : MonoTime;
    alias ss_clock_t = MonoTime;
    ss_clock_t ss_now() { return MonoTime.currTime; }
    double ss_elapsed_ms(ss_clock_t t0) { return (MonoTime.currTime - t0).total!"usecs" / 1000.0; }
}

// timing: MonoTime.currTime is core.time's monotonic clock; TIME_MS goes to stderr and stdout
// is unchanged.
ss_clock_t ss_t0;

void ssReport()
{
    stderr.writefln("TIME_MS=%.3f", ss_elapsed_ms(ss_t0));
}

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
            default:
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
    ss_t0 = ss_now();
    Worker[4] workers;

    foreach (int t; 0 .. 4)
        workers[t] = new Worker(t);

    foreach (ref w; workers)
        w.start();

    thread_joinAll();

    long total = 0;
    foreach (ref w; workers)
        total += w.result;

    ssReport();
    writeln(total);
}
