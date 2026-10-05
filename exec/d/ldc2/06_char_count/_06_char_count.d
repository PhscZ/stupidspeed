// task 06 char_count — expected output: 10000000
// build: dmd -O -release -of=prog _06_char_count.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _06_char_count.d

module _06_char_count;

import std.stdio;
import std.array : replicate;
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

void main()
{
    ss_t0 = ss_now();
    // Built in one operation: "abcdefghij" repeated 10000000 times, 100000000 chars.
    string text = "abcdefghij".replicate(10_000_000);

    long count = 0;
    foreach (char ch; text)
    {
        if (ch == 'h')
            count += 1;
    }

    ssReport();
    writeln(count);
}
