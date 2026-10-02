-- task 05 alloc_churn — expected output: 1274991808
-- build: lean -c 05_alloc_churn.c 05_alloc_churn.lean && leanc -O2 -o prog 05_alloc_churn.c    run: ./prog
-- note: a fresh 64-byte `ByteArray` is allocated every iteration and stored into `slots`, so
--       the previous occupant of that slot becomes garbage. Lean's runtime reclaims it by
--       reference counting rather than by a tracing collector, which is what this measures.

def churn (n : Nat) : UInt64 :=
  go n 0 (Array.replicate 256 ByteArray.empty) 0
where
  go : Nat → Nat → Array ByteArray → UInt64 → UInt64
    | 0, _, _, total => total
    | fuel + 1, i, slots, total =>
      let buf := (ByteArray.mk (Array.replicate 64 (0 : UInt8))).set! 0 (UInt8.ofNat (i % 256))
      go fuel (i + 1) (slots.set! (i % 256) buf) (total + (buf[0]!).toUInt64)

def main : IO Unit := do
  IO.println (churn 10000000)
