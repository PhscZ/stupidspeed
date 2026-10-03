// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: lobster 09_fib_recursive.lobster

def fib(n:int) -> int:
    return if n < 2: n else: fib(n - 1) + fib(n - 2)

print fib(40)
