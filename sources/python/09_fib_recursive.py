# task 09 fib_recursive — expected output: 102334155
# build: python 09_fib_recursive.py | pypy 09_fib_recursive.py | graalpy 09_fib_recursive.py | nuitka --standalone 09_fib_recursive.py    run: python 09_fib_recursive.py

def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)


print(fib(40))
