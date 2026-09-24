# task 14 file_read — expected output: 484442112
# build: nim c -d:release -o:prog _14_file_read.nim    run: ./prog

const chunk = 1024 * 1024
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
echo(total mod 4294967296)
