-- task 11 parallel_sum — expected output: 7500000075000000
-- build: lean -c 11_parallel_sum.c 11_parallel_sum.lean && leanc -O2 -o prog 11_parallel_sum.c    run: ./prog
-- note: `IO.asTask` hands the action to Lean's `Task` runtime, which starts it eagerly on the
--       task worker pool; the compiled program holds 12 OS threads while the four workers run,
--       so these are real threads and not green ones. Measured on this 8-core machine (shared
--       with other work at the time): the same 800 million iterations take 2992 ms on one
--       worker and 1876 ms on four, and a shorter 100-million-iteration run measured 414-430
--       ms against 163-209 ms. The workers overlap, so this is a real speedup, though it came
--       out well short of 4x on a busy box. The answer is exact either way: each worker owns a
--       fixed quarter, so the schedule cannot change the sum.
-- note: the worker body is the same fuel-counted tail recursion as 02_switch_case, which the
--       compiler turns into a plain C loop over unboxed `UInt64`.

def work (t : UInt64) : UInt64 :=
  go 25000000 (t * 25000000) 0
where
  go : Nat → UInt64 → UInt64 → UInt64
    | 0, _, acc => acc
    | fuel + 1, i, acc =>
      match i % 4 with
      | 0 => go fuel (i + 1) (acc + 1)
      | 1 => go fuel (i + 1) (acc + i)
      | 2 => go fuel (i + 1) (acc + 2 * i)
      | _ => go fuel (i + 1) (acc + 3 * i)

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let tasks ← (Array.range 4).mapM fun t =>
    IO.asTask (IO.lazyPure fun _ => work t.toUInt64)
  let mut total : UInt64 := 0
  for t in tasks do
    match ← IO.wait t with
    | Except.ok v => total := total + v
    | Except.error e => throw e
  let t1 ← IO.monoNanosNow
  let ms : Float := (t1 - t0).toFloat / 1000000.0
  IO.eprintln s!"TIME_MS={ms}"
  IO.println total
