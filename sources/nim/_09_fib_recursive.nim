# task 09 fib_recursive — expected output: 102334155
# build: nim c -d:release -o:prog _09_fib_recursive.nim    run: ./prog

import std/monotimes, std/strutils, std/times
proc fib(n: int64): int64 =
  if n < 2: n
  else: fib(n - 1) + fib(n - 2)

let t0 = getMonoTime()
let result = fib(40)
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo result
