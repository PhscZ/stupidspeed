-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: lean -c 01_branches.c 01_branches.lean && leanc -O2 -o prog 01_branches.c    run: ./prog
-- note: Lean's `while`/`for` in `do` keeps its state in a boxed pair and allocates on every
--       iteration, so each task here writes its loop as a tail-recursive function over a `Nat`
--       fuel counter. That is the form the compiler turns into a plain C loop with unboxed
--       `UInt64` accumulators, which is roughly ten times faster.
-- note: `lean --run 01_branches.lean` also runs this, but that is the bytecode interpreter.

def branches (n : Nat) : UInt64 × UInt64 × UInt64 × UInt64 :=
  go n 0 0 0 0 0
where
  go : Nat → UInt64 → UInt64 → UInt64 → UInt64 → UInt64 → UInt64 × UInt64 × UInt64 × UInt64
    | 0, _, a, b, c, d => (a, b, c, d)
    | fuel + 1, i, a, b, c, d =>
      if i % 3 == 0 then go fuel (i + 1) (a + 1) b c d
      else if i % 5 == 0 then go fuel (i + 1) a (b + 1) c d
      else if i % 7 == 0 then go fuel (i + 1) a b (c + 1) d
      else go fuel (i + 1) a b c (d + 1)

@[noinline] def forceIO {α : Type} (x : Unit → α) : IO α := IO.lazyPure x

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let (a, b, c, d) ← forceIO (fun _ => branches 100000000)
  let t1 ← IO.monoNanosNow
  let ms : Float := (t1 - t0).toFloat / 1000000.0
  IO.eprintln s!"TIME_MS={ms}"
  IO.println s!"{a} {b} {c} {d}"
