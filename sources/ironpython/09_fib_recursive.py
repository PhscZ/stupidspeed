# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 09_fib_recursive.py
# note: naive recursion, about 331 million calls; the interpreter's own call path is the thing measured.

def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)

print(fib(40))
