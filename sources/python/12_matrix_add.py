# task 12 matrix_add — expected output: 999000000
# build: python 12_matrix_add.py | pypy 12_matrix_add.py | graalpy 12_matrix_add.py | nuitka --standalone 12_matrix_add.py    run: python 12_matrix_add.py
# build (cython): cython --embed -3 --module-name _12_matrix_add -o _12_matrix_add.c 12_matrix_add.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _12_matrix_add.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
n = 1000
size = n * n

a = [0] * size
b = [0] * size
c = [0] * size

for i in range(n):
    for j in range(n):
        a[i * n + j] = i + j
        b[i * n + j] = i - j

for i in range(n):
    for j in range(n):
        c[i * n + j] = a[i * n + j] + b[i * n + j]

total = 0
for i in range(n):
    for j in range(n):
        total += c[i * n + j]

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(total)
