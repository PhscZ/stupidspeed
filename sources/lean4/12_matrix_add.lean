-- task 12 matrix_add — expected output: 999000000
-- build: lean -c 12_matrix_add.c 12_matrix_add.lean && leanc -O2 -o prog 12_matrix_add.c    run: ./prog
-- note: `Array Int64` is a scalar array, eight bytes per element with no boxing, so the three
--       1000x1000 matrices are 8 MB each and the task measures memory bandwidth. `Int64`
--       matches the C row, including the negative entries of B.
-- note: the matrices are flat, `A[i*n + j]`, the same layout the C row uses.

def build (n : Nat) (f : Nat → Nat → Int64) : Array Int64 :=
  go (n * n) 0 (Array.mkEmpty (n * n))
where
  go : Nat → Nat → Array Int64 → Array Int64
    | 0, _, a => a
    | fuel + 1, k, a => go fuel (k + 1) (a.push (f (k / n) (k % n)))

def add (a b : Array Int64) (elems : Nat) : Array Int64 :=
  go elems 0 (Array.mkEmpty elems)
where
  go : Nat → Nat → Array Int64 → Array Int64
    | 0, _, c => c
    | fuel + 1, k, c => go fuel (k + 1) (c.push (a[k]! + b[k]!))

def sum (a : Array Int64) (elems : Nat) : Int64 :=
  go elems 0 0
where
  go : Nat → Nat → Int64 → Int64
    | 0, _, total => total
    | fuel + 1, k, total => go fuel (k + 1) (total + a[k]!)

def main : IO Unit := do
  let n := 1000
  let elems := n * n
  let a := build n fun i j => Int64.ofNat i + Int64.ofNat j
  let b := build n fun i j => Int64.ofNat i - Int64.ofNat j
  let c := add a b elems
  IO.println (sum c elems)
