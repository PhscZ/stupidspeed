# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 11_parallel_sum.py
# note: IronPython has no GIL in the CPython sense: threading.Thread is a real .NET System.Threading.Thread
#       and the four workers run at once. Measured against this row's own task 02, which does exactly the
#       same 100 million iterations on one thread: 32686 ms serial against 13565 ms on four threads, a real
#       speedup of 2.4x rather than the 4x pure compute would give, because the interpreter's own
#       bookkeeping contends. The row is parallel, not correct-answer-no-speedup.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys
import threading

_sw = Stopwatch.StartNew()

partials = [0, 0, 0, 0]

def work(t):
    acc = 0
    for i in range(t * 25000000, (t + 1) * 25000000):
        m = i % 4
        if m == 0:
            acc += 1
        elif m == 1:
            acc += i
        elif m == 2:
            acc += 2 * i
        else:
            acc += 3 * i
    partials[t] = acc

threads = [threading.Thread(target=work, args=(t,)) for t in range(4)]
for th in threads:
    th.start()
for th in threads:
    th.join()

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(sum(partials))
