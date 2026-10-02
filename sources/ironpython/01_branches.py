# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 01_branches.py
# note: IronPython runs on .NET and has no build step; the interpreter compiles each method to IL as it
#       is first executed. Invoking tools/dotnet8/dotnet.exe by path is enough, but if the host cannot
#       resolve its runtime, set DOTNET_ROOT=tools/dotnet8 first.
# note: every counter is a Python int (arbitrary precision), so no overflow and no double promotion.

a = 0
b = 0
c = 0
d = 0

for i in range(100000000):
    if i % 3 == 0:
        a += 1
    elif i % 5 == 0:
        b += 1
    elif i % 7 == 0:
        c += 1
    else:
        d += 1

print(a, b, c, d)
