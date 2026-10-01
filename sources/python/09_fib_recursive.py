# task 09 fib_recursive — expected output: 102334155
# build: python 09_fib_recursive.py | pypy 09_fib_recursive.py | graalpy 09_fib_recursive.py | nuitka --standalone 09_fib_recursive.py    run: python 09_fib_recursive.py
# build (cython): cython --embed -3 --module-name _09_fib_recursive -o _09_fib_recursive.c 09_fib_recursive.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _09_fib_recursive.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)


print(fib(40))
