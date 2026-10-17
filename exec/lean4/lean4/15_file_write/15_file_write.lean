-- task 15 file_write — expected output: 419430400
-- build: lean -c 15_file_write.c 15_file_write.lean && leanc -O2 -o prog 15_file_write.c    run: ./prog
-- note: the 1 MiB buffer is built by repeated doubling of a 256-byte block, then written fifty
--       times per pass over eight passes (each pass reopening out.bin at offset 0), with one
--       flush per pass. `IO.FS.Handle.flush` is the flush; Lean 4.34's standard library exposes no
--       fsync or FlushFileBuffers binding (`IO.FS.Handle` is opaque and its only durability
--       primitive is `flush`), so this row flushes and then closes, the same deviation the
--       TinyGo row documents for the same reason on Windows.
-- note: `IO.FS.withFile` closes the handle on the way out, which is the second flush.

def repeatBytes (block : ByteArray) (times : Nat) : ByteArray :=
  go times ByteArray.empty block
where
  go : Nat → ByteArray → ByteArray → ByteArray
    | 0, acc, _ => acc
    | count + 1, acc, cur =>
      go ((count + 1) / 2)
         (if (count + 1) % 2 == 1 then acc.append cur else acc)
         (cur.append cur)

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let buf := repeatBytes (ByteArray.mk (Array.ofFn fun i : Fin 256 => UInt8.ofNat i.val)) 4096
  let mut written : Nat := 0
  for _ in [0:8] do
    let n ← IO.FS.withFile "out.bin" IO.FS.Mode.write fun h => do
      for _ in [0:50] do
        h.write buf
      h.flush
      pure (50 * buf.size)
    written := written + n
  let t1 ← IO.monoNanosNow
  let ms : Float := (t1 - t0).toFloat / 1000000.0
  IO.eprintln s!"TIME_MS={ms}"
  IO.println written
