(* task 08 average — expected output: 0.498046875 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/08_average.ML
            (writes 08_average.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 08_average.exe 08_average.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./08_average.exe -H 256   (run from this directory) *)
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
(* note: `Real.fromInt (i mod 256) / 256.0` is the same expression the C row
        evaluates. Every reading is a multiple of 1/256, which is exact in
        binary, and the running total never passes 5e7, so every partial sum
        is exact and the answer does not depend on the order of the
        additions — which is why every row prints the same digits. *)
(* note: `Real.toString` renders this value as 0.498046875 exactly, with a
        period for the decimal point, so no hand-rolled formatter is needed.
        (The Basis also offers `Real.fmt (StringCvt.FIX (SOME 9))`, which
        prints the same thing.) measured: 1.140 s, 11.4 ns per iteration. *)
fun main () =
  let
    val t0 = Time.now ()
    fun loop (i, total) =
      if i >= 100000000 then total
      else loop (i + 1, total + Real.fromInt (i mod 256) / 256.0)
    val total = loop (0, 0.0)
    val result = total / 100000000.0
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Real.toString result ^ "\n")
  end
