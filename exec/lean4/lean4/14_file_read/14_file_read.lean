-- task 14 file_read — expected output: 2389704704
-- build: lean -c 14_file_read.c 14_file_read.lean && leanc -O2 -o prog 14_file_read.c    run: ./prog
-- note: the fixture `data.bin` is read in 1 MiB chunks through `IO.FS.Handle.read`, which
--       returns a `ByteArray`; each chunk is summed byte by byte with `ByteArray.foldl` and
--       the running total is reduced modulo 2^32 at the end.

def sumBytes (b : ByteArray) : UInt64 :=
  b.foldl (fun acc x => acc + x.toUInt64) 0

partial def readAll (h : IO.FS.Handle) (total : UInt64) : IO UInt64 := do
  let chunk ← h.read 1048576
  if chunk.isEmpty then
    return total
  else
    readAll h (total + sumBytes chunk)

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  IO.FS.withFile "data.bin" IO.FS.Mode.read fun h => do
    let total ← readAll h 0
    let t1 ← IO.monoNanosNow
    let ms : Float := (t1 - t0).toFloat / 1000000.0
    IO.eprintln s!"TIME_MS={ms}"
    IO.println (total % 4294967296)
