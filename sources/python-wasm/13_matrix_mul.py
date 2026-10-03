# task 13 matrix_mul — expected output: 599995000
# build: python 13_matrix_mul.py | pypy 13_matrix_mul.py | graalpy 13_matrix_mul.py | nuitka --standalone 13_matrix_mul.py    run: python 13_matrix_mul.py
# build (cython): cython --embed -3 --module-name _13_matrix_mul -o _13_matrix_mul.c 13_matrix_mul.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _13_matrix_mul.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

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

print(total)
