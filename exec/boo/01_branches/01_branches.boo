// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 01_branches.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.

import System.Diagnostics

sw = Stopwatch.StartNew()

a as long = 0
b as long = 0
c as long = 0
d as long = 0

i as long = 0
while i < 100000000:
    if i % 3 == 0:
        a += 1
    elif i % 5 == 0:
        b += 1
    elif i % 7 == 0:
        c += 1
    else:
        d += 1
    i += 1

sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
print("$a $b $c $d")

