// task 06 char_count — expected output: 10000000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 06_char_count.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: the 100 MB text is built with a StringBuilder of the right capacity, ten million appends
//       of the whole ten-character block, so the build is linear. The 'a' and 'e' cases in the
//       task spec fall through to "skip" exactly as the 'h' case falls through to the counter,
//       so only the 'h' test can change the count.

import System.Text
import System.Diagnostics

sw = Stopwatch.StartNew()

block = "abcdefghij"
builder = StringBuilder(100000000)

i as int = 0
while i < 10000000:
    builder.Append(block)
    i += 1
text = builder.ToString()

count as long = 0
i = 0
while i < text.Length:
    if text[i] == char('h'):
        count += 1
    i += 1

sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
print(count)

