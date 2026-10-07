// task 08 average — expected output: 0.498046875
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 08_average.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: the value is printed with the invariant culture. The workstation's default culture is
//       pt-BR, whose decimal separator is a comma, so a plain print would emit 0,498046875.

import System.Globalization
import System.Diagnostics

sw = Stopwatch.StartNew()

total as double = 0.0

i as int = 0
while i < 100000000:
    reading as double = (i % 256) / 256.0
    total = total + reading
    i += 1

sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
print((total / 100000000).ToString("R", CultureInfo.InvariantCulture))

