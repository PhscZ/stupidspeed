// task 02 switch_case — expected output: 7500000075000000
// build: dmd -O -release -of=prog _02_switch_case.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _02_switch_case.d

module _02_switch_case;

import std.stdio;
import core.time : MonoTime;
alias ss_clock_t = MonoTime;
ss_clock_t ss_now() { return MonoTime.currTime; }
double ss_elapsed_ms(ss_clock_t t0) { return (MonoTime.currTime - t0).total!"usecs" / 1000.0; }


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
            default:
                break;
        }
    }

    ssReport();
    writeln(acc);
}
