(* task 04 array_sum — expected output: 599999940000000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/04_array_sum.ML
            (writes 04_array_sum.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 04_array_sum.exe 04_array_sum.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./04_array_sum.exe -H 1024   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: -H 1024 is Poly/ML's initial heap size in megabytes, and it is required, not a
        tuning knob. An exported image starts on the run-time system's default heap and
        grows it on demand; under memory pressure that growth fails and the process dies
        with "Run out of store - interrupting threads" and no output (measured: task 12
        failed in about half of six runs with the default heap, task 06 died silently
        once, and no run failed with the flag). Reserving the heap up front also removes
        the growth steps, which is why task 12 measures about 25 ms with the flag
        against about 55 ms without it. *)
(* note: `Array.array (n, 0)` is a contiguous unboxed int array — Poly/ML
        keeps a 63-bit tagged integer in one word — so this is 80 MB for
        ten million elements, the same width the C row's int64 array has. *)
(* note: the running total passes 2^31 (599999940000000) but Int is 63-bit
        here, so it is exact and `Int.toString` emits plain digits. *)
(* note: the cell is memory-bound, not call-bound: the array is filled once
        and then walked twelve times. *)
fun main () =
  let
    val t0 = Time.now ()
    val n = 10000000
    val arr = Array.array (n, 0)
    fun fill i = if i >= n then () else (Array.update (arr, i, i); fill (i + 1))
    fun sumPass (i, acc) = if i >= n then acc else sumPass (i + 1, acc + Array.sub (arr, i))
    fun sum (pass, acc) = if pass >= 12 then acc else sum (pass + 1, sumPass (0, acc))
    val () = fill 0
    val result = sum (0, 0)
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
