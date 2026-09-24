# task 13 matrix_mul — expected output: 599995000
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py

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
