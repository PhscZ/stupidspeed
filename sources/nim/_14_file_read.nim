# task 14 file_read — expected output: 2389704704
# build: nim c -d:release -o:prog _14_file_read.nim    run: ./prog

import std/monotimes, std/strutils, std/times
const chunk = 1024 * 1024
let t0 = getMonoTime()
var f: File
if not open(f, "data.bin", fmRead):
  quit(1)
var buf = newSeq[byte](chunk)
var total: int64 = 0
while true:
  let got = readBuffer(f, addr buf[0], buf.len)
  if got <= 0: break
  for i in 0 ..< got:
    total += int64(buf[i])
close(f)
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo(total mod 4294967296)
