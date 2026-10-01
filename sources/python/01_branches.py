# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: python 01_branches.py | pypy 01_branches.py | graalpy 01_branches.py | nuitka --standalone 01_branches.py    run: python 01_branches.py
# build (cython): cython --embed -3 --module-name _01_branches -o _01_branches.c 01_branches.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _01_branches.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

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
