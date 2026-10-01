# task 03 func_sum — expected output: 100000000
# build: python 03_func_sum.py | pypy 03_func_sum.py | graalpy 03_func_sum.py | nuitka --standalone 03_func_sum.py    run: python 03_func_sum.py
# note: CPython never inlines this call, so the 100000000 calls really happen; PyPy and the nuitka build may inline it away, since plain Python has no no-inline attribute.
# build (cython): cython --embed -3 --module-name _03_func_sum -o _03_func_sum.c 03_func_sum.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _03_func_sum.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

def add_one(n):
    return n + 1


value = 0
for _ in range(100000000):
    value = add_one(value)

print(value)
