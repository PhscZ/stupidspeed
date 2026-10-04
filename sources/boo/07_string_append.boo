// task 07 string_append — expected output: 250000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 07_string_append.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: System.String is immutable, so `text = text + "x"` copies the whole string every time
//       and the loop is quadratic. That is the point of the task; a StringBuilder would hide it.
// note: this is the row's slow cell.

import System.Diagnostics

sw = Stopwatch.StartNew()

text = ""

i as int = 0
while i < 250000:
    text = text + "x"
    i += 1

sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
print(text.Length)

