(* task 04 array_sum — expected output: 499999500000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/04_array_sum.ML
            (writes 04_array_sum.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 04_array_sum.exe 04_array_sum.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./04_array_sum.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: `Array.array (n, 0)` is a contiguous unboxed int array — Poly/ML
        keeps a 63-bit tagged integer in one word — so this is 8 MB for a
        million elements, the same width the C row's int64 array has. *)
(* note: the running total passes 2^31 (499999500000) but Int is 63-bit
        here, so it is exact and `Int.toString` emits plain digits. *)
(* note: measured: 0.082 s. The cell is memory-bound, not call-bound: 8 MB
        is filled and then walked. *)
fun main () =
  let
    val n = 1000000
    val arr = Array.array (n, 0)
    fun fill i = if i >= n then () else (Array.update (arr, i, i); fill (i + 1))
    fun sum (i, acc) = if i >= n then acc else sum (i + 1, acc + Array.sub (arr, i))
  in
    fill 0;
    print (Int.toString (sum (0, 0)) ^ "\n")
  end
