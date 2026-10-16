-- task 13 matrix_mul — expected output: 599995000
-- build: lean -c 13_matrix_mul.c 13_matrix_mul.lean && leanc -O2 -o prog 13_matrix_mul.c    run: ./prog
-- note: plain i, j, k triple loop in that order, over flat scalar `Int64` arrays, so the
--       125 million multiply-adds are the same work as the C row's. No loop reordering, no
--       blocking.

def build (n : Nat) (f : Nat → Nat → Int64) : Array Int64 :=
  go (n * n) 0 (Array.mkEmpty (n * n))
where
  go : Nat → Nat → Array Int64 → Array Int64
    | 0, _, a => a
    | fuel + 1, k, a => go fuel (k + 1) (a.push (f (k / n) (k % n)))

/-- The dot product of row `i` of `a` with column `j` of `b`, for square `n` by `n` matrices. -/
def dot (a b : Array Int64) (n i j : Nat) : Int64 :=
  go n 0 0
where
  go : Nat → Nat → Int64 → Int64
    | 0, _, sum => sum
    | fuel + 1, k, sum => go fuel (k + 1) (sum + a[i * n + k]! * b[k * n + j]!)

def mul (a b : Array Int64) (n : Nat) : Array Int64 :=
  go (n * n) 0 (Array.mkEmpty (n * n))
where
  go : Nat → Nat → Array Int64 → Array Int64
    | 0, _, c => c
    | fuel + 1, k, c => go fuel (k + 1) (c.push (dot a b n (k / n) (k % n)))

def sum (a : Array Int64) (elems : Nat) : Int64 :=
  go elems 0 0
where
  go : Nat → Nat → Int64 → Int64
    | 0, _, total => total
    | fuel + 1, k, total => go fuel (k + 1) (total + a[k]!)

@[noinline] def forceIO {α : Type} (x : Unit → α) : IO α := IO.lazyPure x

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let n := 500
  let elems := n * n
  let a := build n fun i j => Int64.ofNat ((i + j) % 7)
  let b := build n fun i j => Int64.ofNat ((i * j) % 5)
  let c := mul a b n
  let answer ← forceIO (fun _ => sum c elems)
  let t1 ← IO.monoNanosNow
  let ms : Float := (t1 - t0).toFloat / 1000000.0
  IO.eprintln s!"TIME_MS={ms}"
  IO.println answer
