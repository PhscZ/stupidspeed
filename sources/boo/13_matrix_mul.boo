// task 13 matrix_mul — expected output: 599995000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 13_matrix_mul.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: plain i, j, k triple loop with k innermost, no reordering; the matrices are flat long[]
//       arrays for the same reason as task 12.

n = 500
a = array[of long](n * n)
b = array[of long](n * n)
c = array[of long](n * n)

i as int = 0
while i < n:
    j as int = 0
    while j < n:
        a[i * n + j] = (i + j) % 7
        b[i * n + j] = (i * j) % 5
        j += 1
    i += 1

i = 0
while i < n:
    j = 0
    while j < n:
        sum as long = 0
        k as int = 0
        while k < n:
            sum += a[i * n + k] * b[k * n + j]
            k += 1
        c[i * n + j] = sum
        j += 1
    i += 1

total as long = 0
idx as int = 0
while idx < n * n:
    total += c[idx]
    idx += 1

print(total)

