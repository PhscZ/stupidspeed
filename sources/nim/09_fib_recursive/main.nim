# task 09 fib_recursive — expected output: 102334155
# build: nim c -d:release -o:prog main.nim    run: ./prog

proc fib(n: int64): int64 =
  if n < 2: n
  else: fib(n - 1) + fib(n - 2)

echo fib(40)
