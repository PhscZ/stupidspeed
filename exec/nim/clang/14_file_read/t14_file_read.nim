# task 14 file_read — expected output: 1937768448
# build: nim c -d:release -o:prog _14_file_read.nim    run: ./prog
# note: data.bin is read in 1 MiB chunks, eight times over, reopened at the start of each pass.

import std/monotimes, std/strutils, std/times
const chunk = 1024 * 1024
let t0 = getMonoTime()
var buf = newSeq[byte](chunk)
var total: int64 = 0
for pass in 0 ..< 8:
  var f: File
  if not open(f, "data.bin", fmRead):
    quit(1)
  while true:
    let got = readBuffer(f, addr buf[0], buf.len)
    if got <= 0: break
    for i in 0 ..< got:
      total += int64(buf[i])
  close(f)
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo(total mod 4294967296)
