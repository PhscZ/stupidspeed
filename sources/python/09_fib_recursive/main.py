# task 09 fib_recursive — expected output: 102334155
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py

def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)


print(fib(40))
