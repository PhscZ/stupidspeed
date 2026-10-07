# task 07 string_append — expected output: 250000
# build: python 07_string_append.py | pypy 07_string_append.py | graalpy 07_string_append.py | nuitka --standalone 07_string_append.py    run: python 07_string_append.py
# build (cython): cython --embed -3 --module-name _07_string_append -o _07_string_append.c 07_string_append.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _07_string_append.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
text = ''
for _ in range(250000):
    text += 'x'

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(len(text))
