# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 06_char_count.py
# note: the 100000000-character text is built once by repeating the 10-character block, never by
#       appending. .NET strings are UTF-16, but every character here is ASCII.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

text = 'abcdefghij' * 10000000

count = 0
for ch in text:
    if ch == 'a':
        pass
    elif ch == 'e':
        pass
    elif ch == 'h':
        count += 1
    else:
        pass

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(count)
