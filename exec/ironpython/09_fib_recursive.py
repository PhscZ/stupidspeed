# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 09_fib_recursive.py
# note: naive recursion, about 331 million calls; the interpreter's own call path is the thing measured.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)

_result = fib(40)
_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(_result)
