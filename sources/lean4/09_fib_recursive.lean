-- task 09 fib_recursive — expected output: 102334155
-- build: lean -c 09_fib_recursive.c 09_fib_recursive.lean && leanc -O2 -o prog 09_fib_recursive.c    run: ./prog
-- note: the three-clause definition below is Lean's structural recursion on `Nat`, so it is
--       accepted without a termination proof and compiles to two real self-calls. It makes
--       the usual 331 million calls for fib 40. The accumulators are `UInt64`, as in the
--       other counter tasks.

def fib : Nat → UInt64
  | 0 => 0
  | 1 => 1
  | n + 2 => fib (n + 1) + fib n

def main : IO Unit := do
  IO.println (fib 40)
