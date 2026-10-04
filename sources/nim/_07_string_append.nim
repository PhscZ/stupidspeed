# task 07 string_append — expected output: 250000
# build: nim c -d:release -o:prog _07_string_append.nim    run: ./prog
#
# `&` builds a new string, so every append copies the whole string (quadratic),
# which is what this task measures. `add` would grow the buffer in place instead.

import std/monotimes, std/strutils, std/times
let t0 = getMonoTime()
var text = ""
for _ in 0 ..< 250_000:
  text = text & "x"
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo text.len
