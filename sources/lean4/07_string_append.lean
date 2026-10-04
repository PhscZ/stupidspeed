-- task 07 string_append — expected output: 250000
-- build: lean -c 07_string_append.c 07_string_append.lean && leanc -O2 -o prog 07_string_append.c    run: ./prog
-- note: `String.push` is Lean's `text + "x"`. It grows the string in place whenever the
--       reference count is one, so the loop is linear; if it copied, this would be quadratic.

def appendXs (n : Nat) : String :=
  go n ""
where
  go : Nat → String → String
    | 0, text => text
    | n + 1, text => go n (text.push 'x')

@[noinline] def forceIO {α : Type} (x : Unit → α) : IO α := IO.lazyPure x

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let answer ← forceIO (fun _ => (appendXs 250000).length)
  let t1 ← IO.monoNanosNow
  let ms : Float := (t1 - t0).toFloat / 1000000.0
  IO.eprintln s!"TIME_MS={ms}"
  IO.println answer
