// task 02 switch_case — expected output: 7500000075000000
// build: dmd -O -release -of=prog _02_switch_case.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _02_switch_case.d

module _02_switch_case;

import std.stdio;
import core.time : MonoTime;

// timing: MonoTime.currTime is core.time's monotonic clock; TIME_MS goes to stderr and stdout
// is unchanged.
MonoTime ss_t0;

void ssReport()
{
    stderr.writefln("TIME_MS=%.3f", (MonoTime.currTime - ss_t0).total!"usecs" / 1000.0);
}

void main()
{
    ss_t0 = MonoTime.currTime;
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
