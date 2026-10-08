# task 13 matrix_mul — expected output: 599995000
# build: python 13_matrix_mul.py | pypy 13_matrix_mul.py | graalpy 13_matrix_mul.py | nuitka --standalone 13_matrix_mul.py    run: python 13_matrix_mul.py
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
n = 500
size = n * n

a = [0] * size
b = [0] * size
c = [0] * size

for i in range(n):
    for j in range(n):
        a[i * n + j] = (i + j) % 7
        b[i * n + j] = (i * j) % 5

for i in range(n):
    for j in range(n):
        s = 0
        for k in range(n):
            s += a[i * n + k] * b[k * n + j]
        c[i * n + j] = s

total = 0
for i in range(n):
    for j in range(n):
        total += c[i * n + j]

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(total)
