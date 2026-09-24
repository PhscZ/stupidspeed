# task 03 func_sum — expected output: 100000000
# build: python 03_func_sum.py | pypy 03_func_sum.py | graalpy 03_func_sum.py | nuitka --standalone 03_func_sum.py    run: python 03_func_sum.py
# note: CPython never inlines this call, so the 100000000 calls really happen; PyPy and the nuitka build may inline it away, since plain Python has no no-inline attribute.

def add_one(n):
    return n + 1


value = 0
for _ in range(100000000):
    value = add_one(value)

print(value)
