# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 02_switch_case.py
# note: IronPython 3.4 predates Python's match statement, so the four-way decision is an if/elif chain;
#       the .NET compiler behind it has no jump table to compare against task 01.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

acc = 0

for i in range(100000000):
    m = i % 4
    if m == 0:
        acc += 1
    elif m == 1:
        acc += i
    elif m == 2:
        acc += 2 * i
    else:
        acc += 3 * i

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(acc)
