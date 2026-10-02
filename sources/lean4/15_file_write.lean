-- task 15 file_write — expected output: 52428800
-- build: lean -c 15_file_write.c 15_file_write.lean && leanc -O2 -o prog 15_file_write.c    run: ./prog
-- note: the 1 MiB buffer is built by repeated doubling of a 256-byte block, then written fifty
--       times. `IO.FS.Handle.flush` is the flush; Lean 4.34's standard library exposes no
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
  let buf := repeatBytes (ByteArray.mk (Array.ofFn fun i : Fin 256 => UInt8.ofNat i.val)) 4096
  IO.FS.withFile "out.bin" IO.FS.Mode.write fun h => do
    let mut written : Nat := 0
    for _ in [0:50] do
      h.write buf
      written := written + buf.size
    h.flush
    IO.println written
