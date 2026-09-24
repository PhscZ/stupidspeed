# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py

a = 0
b = 0
c = 0
d = 0

for i in range(100000000):
    if i % 3 == 0:
        a += 1
    elif i % 5 == 0:
        b += 1
    elif i % 7 == 0:
        c += 1
    else:
        d += 1

print(a, b, c, d)
