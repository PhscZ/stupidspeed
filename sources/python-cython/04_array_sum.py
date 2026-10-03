# task 04 array_sum — expected output: 499999500000
# build: python 04_array_sum.py | pypy 04_array_sum.py | graalpy 04_array_sum.py | nuitka --standalone 04_array_sum.py    run: python 04_array_sum.py
# build (cython): cython --embed -3 --module-name _04_array_sum -o _04_array_sum.c 04_array_sum.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _04_array_sum.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

array = [0] * 1000000

for i in range(1000000):
    array[i] = i

total = 0
for i in range(1000000):
    total += array[i]

print(total)
