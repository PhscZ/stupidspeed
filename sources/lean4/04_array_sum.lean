-- task 04 array_sum — expected output: 599999940000000
-- build: lean -c 04_array_sum.c 04_array_sum.lean && leanc -O2 -o prog 04_array_sum.c    run: ./prog
-- note: `Array UInt64` is a scalar array in the runtime, eight bytes per element and no
--       boxing, so the two passes walk contiguous memory.

def fill (n : Nat) : Array UInt64 :=
  go n 0 (Array.mkEmpty n)
where
  go : Nat → Nat → Array UInt64 → Array UInt64
    | 0, _, a => a
    | fuel + 1, i, a => go fuel (i + 1) (a.push i.toUInt64)

def sum (a : Array UInt64) (n : Nat) : UInt64 :=
  go n 0 0
where
  go : Nat → Nat → UInt64 → UInt64
    | 0, _, total => total
    | fuel + 1, i, total => go fuel (i + 1) (total + a[i]!)

def sum12 (a : Array UInt64) (n : Nat) : UInt64 :=
  go 12 0
where
  go : Nat → UInt64 → UInt64
    | 0, total => total
    | fuel + 1, total => go fuel (total + sum a n)

@[noinline] def forceIO {α : Type} (x : Unit → α) : IO α := IO.lazyPure x

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let n := 10000000
  let a := fill n
  let answer ← forceIO (fun _ => sum12 a n)
  let t1 ← IO.monoNanosNow
  let ms : Float := (t1 - t0).toFloat / 1000000.0
  IO.eprintln s!"TIME_MS={ms}"
  IO.println answer
