// task 12 matrix_add — expected output: 999000000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 12_matrix_add.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: the three matrices are flat long[] arrays, as in the C# row: matrix[of long](n, n) would
//       be a real long[,] and pay the bounds-checked two-dimensional indexer on every access.

n = 1000
a = array[of long](n * n)
b = array[of long](n * n)
c = array[of long](n * n)

i as int = 0
while i < n:
    j as int = 0
    while j < n:
        a[i * n + j] = i + j
        b[i * n + j] = i - j
        j += 1
    i += 1

idx as int = 0
while idx < n * n:
    c[idx] = a[idx] + b[idx]
    idx += 1

total as long = 0
idx = 0
while idx < n * n:
    total += c[idx]
    idx += 1

print(total)

