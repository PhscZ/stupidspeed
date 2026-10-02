// task 03 func_sum — expected output: 100000000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 03_func_sum.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: [MethodImpl(MethodImplOptions.NoInlining)] is honoured -- the emitted method carries the
//       NoInlining implementation flag (checked with MethodInfo.GetMethodImplementationFlags),
//       so the call really happens a hundred million times.

import System.Runtime.CompilerServices

[MethodImpl(MethodImplOptions.NoInlining)]
def add_one(n as long) as long:
    return n + 1

value as long = 0

i as long = 0
while i < 100000000:
    value = add_one(value)
    i += 1

print(value)

