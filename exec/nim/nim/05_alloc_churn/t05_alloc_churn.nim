# task 05 alloc_churn — expected output: 1274991808
# build: nim c -d:release -o:prog _05_alloc_churn.nim    run: ./prog

import std/monotimes, std/strutils, std/times
let t0 = getMonoTime()
var total: int64 = 0
var slots: array[256, seq[byte]]
for i in 0 ..< 10_000_000:
  var buf = newSeq[byte](64)
  buf[0] = byte(i mod 256)
  total += int64(buf[0])
  slots[i mod 256] = buf
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo total
