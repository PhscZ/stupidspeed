# task 10 pi — expected output: 44889
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py
# note: Gibbons' unbounded spigot on Python's native arbitrary-precision ints; only the sum of the first 10000 emitted digits is printed, never the digits.

DIGITS = 10000

q, r, t, k, n, l = 1, 0, 1, 1, 3, 3
total = 0
emitted = 0

while emitted < DIGITS:
    if 4 * q + r - t < n * t:
        total += n
        emitted += 1
        q, r, t, k, n, l = 10 * q, 10 * (r - n * t), t, k, (10 * (3 * q + r)) // t - 10 * n, l
    else:
        q, r, t, k, n, l = q * k, (2 * q + r) * l, t * l, k + 1, (q * (7 * k + 2) + r * l) // (t * l), l + 2

print(total)
