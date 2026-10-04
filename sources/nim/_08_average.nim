# task 08 average — expected output: 0.498046875
# build: nim c -d:release -o:prog _08_average.nim    run: ./prog

import std/monotimes, std/strutils, std/times
let t0 = getMonoTime()
var total = 0.0
for i in 0 ..< 100_000_000:
  let reading = float(i mod 256) / 256.0
  total += reading
let average = total / 100_000_000.0
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo average
