# task 03 func_sum — expected output: 100000000
# build: nim c -d:release -o:prog main.nim    run: ./prog

proc addOne(n: int64): int64 {.noinline.} =
  n + 1

var value: int64 = 0
for _ in 0 ..< 100_000_000:
  value = addOne(value)
echo value
