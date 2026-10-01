# task 05 alloc_churn — expected output: 1274991808
# build: python 05_alloc_churn.py | pypy 05_alloc_churn.py | graalpy 05_alloc_churn.py | nuitka --standalone 05_alloc_churn.py    run: python 05_alloc_churn.py
# build (cython): cython --embed -3 --module-name _05_alloc_churn -o _05_alloc_churn.c 05_alloc_churn.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _05_alloc_churn.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

total = 0
slots = [None] * 256

for i in range(10000000):
    buf = bytearray(64)
    buf[0] = i % 256
    total += buf[0]
    slots[i % 256] = buf

print(total)
