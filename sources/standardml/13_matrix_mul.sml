(* task 13 matrix_mul — expected output: 599995000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/13_matrix_mul.ML
            (writes 13_matrix_mul.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 13_matrix_mul.exe 13_matrix_mul.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./13_matrix_mul.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: flat 250000-element arrays indexed `i * n + j`, the same layout the
        C row uses. *)
(* note: the loop order is the plain i, j, k the spec asks for, so B is
        walked down a column at a time and the access pattern is the
        cache-hostile one. Reordering to i, k, j would be faster, and that
        is the point of the task, so it is left alone. *)
(* note: each element of C is a sum of 500 terms each at most 6 * 4 = 24, so
        it fits easily in a 63-bit Int; the grand total, 599995000, is
        exact. *)
(* note: measured: 0.617 s for 125 million multiply-adds, 4.9 ns each. *)
fun main () =
  let
    val t0 = Time.now ()
    val n = 500
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
              (Array.update (a, i * n + j, (i + j) mod 7);
               Array.update (b, i * n + j, (i * j) mod 5);
               row (j + 1))
        in
          row 0; build (i + 1)
        end
    fun mul i =
      if i >= n then ()
      else
        let
          fun row j =
            if j >= n then ()
            else
              let
                fun kloop (k, acc) =
                  if k >= n then acc
                  else kloop (k + 1, acc + Array.sub (a, i * n + k) * Array.sub (b, k * n + j))
              in
                Array.update (c, i * n + j, kloop (0, 0)); row (j + 1)
              end
        in
          row 0; mul (i + 1)
        end
    fun sum (i, acc) = if i >= n * n then acc else sum (i + 1, acc + Array.sub (c, i))
    val () = build 0
    val () = mul 0
    val result = sum (0, 0)
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
