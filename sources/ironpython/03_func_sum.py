# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 03_func_sum.py
# note: plain Python has no no-inline marker, and IronPython has no promise to give. The body is
#       compiled to a .NET method and the call is a real dynamic dispatch each time, so the
#       100000000 calls happen.

def add_one(n):
    return n + 1

value = 0
for _ in range(100000000):
    value = add_one(value)

print(value)
