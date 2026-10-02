-- task 02 switch_case — expected output: 7500000075000000
-- build: lean -c 02_switch_case.c 02_switch_case.lean && leanc -O2 -o prog 02_switch_case.c    run: ./prog
-- note: `match` on a `UInt64` with literal patterns is what Lean compiles as a jump table;
--       the loop is the fuel-counted tail recursion described in 01_branches.lean.

def switchCase (n : Nat) : UInt64 :=
  go n 0 0
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
  IO.println (switchCase 100000000)
