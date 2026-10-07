(* task 12 matrix_add — expected output: 999000000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/12_matrix_add.ML
            (writes 12_matrix_add.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 12_matrix_add.exe 12_matrix_add.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./12_matrix_add.exe -H 256   (run from this directory) *)
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
(* note: the three matrices are flat million-element int arrays indexed `i *
        n + j`, the same layout the C row uses. A 1000x1000 array of Int is
        8 MB each, so the working set is 24 MB and does not fit in cache —
        which is the point of the task. *)
(* note: A holds i + j and B holds i - j, both small signed values; C holds
        their sum. The grand total, 999000000, is exact in a 63-bit Int. *)
(* note: measured: 0.096 s, the second-fastest cell in the row. *)
fun main () =
  let
    val t0 = Time.now ()
    val n = 1000
    val a = Array.array (n * n, 0)
    val b = Array.array (n * n, 0)
    val c = Array.array (n * n, 0)
    fun build i =
      if i >= n then ()
      else
        let
          fun row j =
            if j >= n then ()
            else
              (Array.update (a, i * n + j, i + j);
               Array.update (b, i * n + j, i - j);
               row (j + 1))
        in
          row 0; build (i + 1)
        end
    fun add i =
      if i >= n * n then ()
      else (Array.update (c, i, Array.sub (a, i) + Array.sub (b, i)); add (i + 1))
    fun sum (i, acc) = if i >= n * n then acc else sum (i + 1, acc + Array.sub (c, i))
    val () = build 0
    val () = add 0
    val result = sum (0, 0)
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
