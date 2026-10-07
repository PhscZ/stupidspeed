(* task 10 pi — expected output: 4470 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/10_pi.ML
            (writes 10_pi.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 10_pi.exe 10_pi.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./10_pi.exe -H 256   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: -H 256 is Poly/ML's initial heap size in megabytes, and it is required, not a
        tuning knob. An exported image starts on the run-time system's default heap and
        grows it on demand; under memory pressure that growth fails and the process dies
        with "Run out of store - interrupting threads" and no output (measured: task 12
        failed in about half of six runs with the default heap, task 06 died silently
        once, and no run failed with -H 256). Reserving the heap up front also removes
        the growth steps, which is why task 12 measures about 25 ms with the flag
        against about 55 ms without it. *)
(* note: Poly/ML has a real arbitrary-precision integer type in its standard
        library, `IntInf`, so this uses it directly — the route the rules
        prefer where one exists, and the same choice Python, Ruby, Java,
        Scheme and the other bignum rows make. No hand-rolled limbs here. *)
(* note: the algorithm is Gibbons' unbounded spigot, step for step: the
        state is (q, r, t, k, n, l), a digit is emitted when `4q + r - t <
        n*t`, and the sum of the 1000 emitted digits is printed. *)
(* note: `div` is the floor division IntInf needs for the quotient. Every
        operand is non-negative, so floor and truncating division agree and
        either would do. *)
(* note: measured: 0.1927 s at 1000 digits (0.242 s as a linked executable,
        which includes the 65 ms start-up). The reduced-scale digit sums are
        100 -> 471 and 400 -> 1753, and 1000 -> 4470, which is the number
        README publishes for every row. *)
fun main () =
  let
    val t0 = Time.now ()
    val NDIG = 1000
    fun go (q : IntInf.int, r, t, k, nn, l, count, acc) =
      if count >= NDIG then acc
      else if 4 * q + r - t < nn * t then
        go (10 * q, 10 * (r - nn * t), t, k,
            (10 * (3 * q + r)) div t - 10 * nn, l, count + 1, acc + nn)
      else
        go (q * k, (2 * q + r) * l, t * l, k + 1,
            (q * (7 * k + 2) + r * l) div (t * l), l + 2, count, acc)
    val total = go (1, 0, 1, 1, 3, 3, 0, 0)
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (IntInf.toString total ^ "\n")
  end
