// task 09 fib_recursive — expected output: 102334155
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 09_fib_recursive.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.

import System.Diagnostics

def fib(n as int) as long:
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)

sw = Stopwatch.StartNew()
result = fib(40)
sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
print(result)

