// task 04 array_sum — expected output: 499999500000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 04_array_sum.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: array[of long](n) is the generic builtin, which the compiler rewrites to a real
//       newarr/stelem/ldelem sequence; array(long, n) would instead call
//       Boo.Lang.Builtins.array(Type, int) and Array.CreateInstance at run time.

arr = array[of long](1000000)

i as int = 0
while i < 1000000:
    arr[i] = i
    i += 1

total as long = 0
i = 0
while i < 1000000:
    total += arr[i]
    i += 1

print(total)

