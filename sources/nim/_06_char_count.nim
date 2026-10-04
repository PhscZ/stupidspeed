# task 06 char_count — expected output: 10000000
# build: nim c -d:release -o:prog _06_char_count.nim    run: ./prog

import std/strutils
import std/monotimes, std/times

let t0 = getMonoTime()
let text = repeat("abcdefghij", 10_000_000)
var count: int64 = 0
for ch in text:
  if ch == 'a': discard
  elif ch == 'e': discard
  elif ch == 'h': inc count
  else: discard
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo count
