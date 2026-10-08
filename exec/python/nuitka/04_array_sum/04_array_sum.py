# task 04 array_sum — expected output: 499999500000
# build: python 04_array_sum.py | pypy 04_array_sum.py | graalpy 04_array_sum.py | nuitka --standalone 04_array_sum.py    run: python 04_array_sum.py
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
array = [0] * 1000000

for i in range(1000000):
    array[i] = i

total = 0
for i in range(1000000):
    total += array[i]

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(total)
