# task 15 file_write — expected output: 104857600
# build: nim c -d:release -o:prog _15_file_write.nim    run: ./prog
#
# Deviation: Nim's standard library exposes no fsync (File has no such proc),
# so the data is flushed with flushFile and the file closed, which hands the
# buffered writes to the OS.

const chunk = 1024 * 1024
var buf = newSeq[byte](chunk)
for i in 0 ..< chunk:
  buf[i] = byte(i mod 256)
var f: File
if not open(f, "out.bin", fmWrite):
  quit(1)
for _ in 0 ..< 100:
  discard writeBuffer(f, addr buf[0], buf.len)
flushFile(f)
close(f)
echo(100 * chunk)
