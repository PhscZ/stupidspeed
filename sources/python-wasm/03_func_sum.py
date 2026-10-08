# task 03 func_sum — expected output: 100000000
# build: python 03_func_sum.py | pypy 03_func_sum.py | graalpy 03_func_sum.py | nuitka --standalone 03_func_sum.py    run: python 03_func_sum.py
# note: CPython never inlines this call, so the 100000000 calls really happen; PyPy and the nuitka build may inline it away, since plain Python has no no-inline attribute.
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
def add_one(n):
    return n + 1


value = 0
for _ in range(100000000):
    value = add_one(value)

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(value)
