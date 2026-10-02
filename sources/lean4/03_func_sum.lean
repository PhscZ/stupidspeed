-- task 03 func_sum — expected output: 100000000
-- build: lean -c 03_func_sum.c 03_func_sum.lean && leanc -O2 -o prog 03_func_sum.c    run: ./prog
-- note: `@[noinline]` is Lean's own no-inline marker, so `add_one` stays a separate function
--       in the C that `lean -c` emits and the 100000000 calls are real calls at the language
--       level. The C compiler that `leanc` drives still inlines that function at its single
--       call site inside the one translation unit, so the machine code is one loop; the
--       language-level call, which is what this task is about, is preserved.

@[noinline] def addOne (n : UInt64) : UInt64 := n + 1

def funcSum (n : Nat) : UInt64 :=
  go n 0 0
where
  go : Nat → UInt64 → UInt64 → UInt64
    | 0, _, value => value
    | fuel + 1, i, value => go fuel (i + 1) (addOne value)

def main : IO Unit := do
  IO.println (funcSum 100000000)
