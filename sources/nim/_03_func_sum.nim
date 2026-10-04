# task 03 func_sum — expected output: 100000000
# build: nim c -d:release -o:prog _03_func_sum.nim    run: ./prog

import std/monotimes, std/strutils, std/times
proc addOne(n: int64): int64 {.noinline.} =
  n + 1

let t0 = getMonoTime()
var value: int64 = 0
for _ in 0 ..< 100_000_000:
  value = addOne(value)
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo value
