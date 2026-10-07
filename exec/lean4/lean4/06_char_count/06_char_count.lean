-- task 06 char_count — expected output: 10000000
-- build: lean -c 06_char_count.c 06_char_count.lean && leanc -O2 -o prog 06_char_count.c    run: ./prog
-- note: Lean's `String` is a UTF-8 `ByteArray` under the hood and cannot be assembled without
--       a validity proof, so the 100 MB text is first built as that byte array by repeated
--       doubling of the ten-byte block (twenty appends in total, not one per character) and
--       then handed to `String.fromUTF8?`, which succeeds because the block is ASCII.
-- note: the scan is `String.foldl` over characters, exactly the loop in the task.

def repeatBytes (block : ByteArray) (times : Nat) : ByteArray :=
  go times ByteArray.empty block
where
  go : Nat → ByteArray → ByteArray → ByteArray
    | 0, acc, _ => acc
    | count + 1, acc, cur =>
      go ((count + 1) / 2)
         (if (count + 1) % 2 == 1 then acc.append cur else acc)
         (cur.append cur)

def charCount (text : String) : UInt64 :=
  text.foldl (fun acc ch => if ch == 'h' then acc + 1 else acc) 0

@[noinline] def forceIO {α : Type} (x : Unit → α) : IO α := IO.lazyPure x

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let bytes := repeatBytes "abcdefghij".toUTF8 10000000
  match String.fromUTF8? bytes with
  | some text =>
    let answer ← forceIO (fun _ => charCount text)
    let t1 ← IO.monoNanosNow
    let ms : Float := (t1 - t0).toFloat / 1000000.0
    IO.eprintln s!"TIME_MS={ms}"
    IO.println answer
  | none => throw (IO.userError "text is not valid UTF-8")
