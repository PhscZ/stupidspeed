# task 06 char_count — expected output: 10000000
# build: python 06_char_count.py | pypy 06_char_count.py | graalpy 06_char_count.py | nuitka --standalone 06_char_count.py    run: python 06_char_count.py
# note: the 100000000-character text is built once by repeating the 10-character block, never by appending.
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
text = 'abcdefghij' * 10000000

count = 0
for ch in text:
    if ch == 'a':
        pass
    elif ch == 'e':
        pass
    elif ch == 'h':
        count += 1
    else:
        pass

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(count)
