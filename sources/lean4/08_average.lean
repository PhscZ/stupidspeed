-- task 08 average — expected output: 0.498046875
-- build: lean -c 08_average.c 08_average.lean && leanc -O2 -o prog 08_average.c    run: ./prog
-- note: Lean's `Float` is the C `double`, so this is f64.
-- note: `Float.toString` prints only six significant decimals ("0.498047"), which would lose
--       the answer, so the last function here decodes the IEEE-754 bits with `Float.toBits`
--       and prints the exact decimal value of the double: the value is m * 2^e, and for
--       e < 0 that is (m * 5^-e) with the point shifted -e places left. The integers involved
--       come from `Nat`, which is arbitrary precision, so nothing is rounded on the way out.

def avg (n : Nat) : Float :=
  go n 0 0.0
where
  go : Nat → UInt64 → Float → Float
    | 0, _, total => total
    | fuel + 1, i, total => go fuel (i + 1) (total + (i % 256).toFloat / 256.0)

/-- The exact decimal expansion of a finite double. -/
def exactFloat (x : Float) : String :=
  if x == 0.0 then "0"
  else
    let bits := Float.toBits x
    let neg := bits >>> 63 == 1
    let expField := (bits >>> 52) &&& 0x7FF
    let frac := bits &&& 0xFFFFFFFFFFFFF
    let (m, e) : Nat × Int :=
      if expField == 0 then (frac.toNat, -1074)
      else ((frac + 0x10000000000000).toNat, expField.toNat - 1075)
    let sign := if neg then "-" else ""
    if e ≥ 0 then
      sign ++ (m <<< e.toNat).repr
    else
      let places := (-e).toNat
      let digits := (m * 5 ^ places).repr
      let padded := String.ofList (List.replicate (places + 1 - digits.length) '0') ++ digits
      let intPart := (padded.take (padded.length - places)).toString
      let fracPart := (padded.drop (padded.length - places)).toString.dropEndWhile '0'
      if fracPart.isEmpty then sign ++ intPart else sign ++ intPart ++ "." ++ fracPart

@[noinline] def forceIO {α : Type} (x : Unit → α) : IO α := IO.lazyPure x

def main : IO Unit := do
  let t0 ← IO.monoNanosNow
  let answer ← forceIO (fun _ => exactFloat (avg 100000000 / 100000000.0))
  let t1 ← IO.monoNanosNow
  let ms : Float := (t1 - t0).toFloat / 1000000.0
  IO.eprintln s!"TIME_MS={ms}"
  IO.println answer
