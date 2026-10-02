-- task 10 pi — expected output: 4470
-- build: lean -c 10_pi.c 10_pi.lean && leanc -O2 -o prog 10_pi.c    run: ./prog
-- note: `Int` is Lean's arbitrary-precision integer, so the spigot state is carried directly
--       and the two divisions are real divisions. The comparison `4*q + r - t < n*t` and the
--       state updates go negative in this algorithm, which is why the state is `Int` and not
--       `Nat`: truncated-subtraction `Nat` gets stuck at zero and the spigot then never emits.
-- note: `/` on `Int` is `Int.ediv`, the floor division, which is what the algorithm wants.

structure St where
  q : Int
  r : Int
  t : Int
  k : Int
  n : Int
  l : Int
  deriving Inhabited

def spigot (digits : Nat) : Nat × Nat :=
  go (digits * 1000) { q := 1, r := 0, t := 1, k := 1, n := 3, l := 3 } 0 0
where
  go : Nat → St → Nat → Nat → Nat × Nat
    | 0, _, emitted, sum => (sum, emitted)
    | fuel + 1, s, emitted, sum =>
      if emitted ≥ digits then (sum, emitted)
      else if 4 * s.q + s.r - s.t < s.n * s.t then
        go fuel
          { q := 10 * s.q, r := 10 * (s.r - s.n * s.t), t := s.t, k := s.k,
            n := 10 * (3 * s.q + s.r) / s.t - 10 * s.n, l := s.l }
          (emitted + 1) (sum + s.n.toNat)
      else
        go fuel
          { q := s.q * s.k, r := (2 * s.q + s.r) * s.l, t := s.t * s.l, k := s.k + 1,
            n := (s.q * (7 * s.k + 2) + s.r * s.l) / (s.t * s.l), l := s.l + 2 }
          emitted sum

def main : IO Unit := do
  let (sum, emitted) := spigot 1000
  if emitted != 1000 then
    throw (IO.userError s!"spigot stopped after {emitted} digits")
  IO.println sum
