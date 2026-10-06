(* task 09 fib_recursive — expected output: 102334155 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/09_fib_recursive.ML
            (writes 09_fib_recursive.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 09_fib_recursive.exe 09_fib_recursive.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./09_fib_recursive.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: the plain double recursion the spec asks for: no memoization, no
        accumulator, no iterative rewrite. fib(40) is about 331 million
        calls. *)
(* note: the result, 102334155, is below 2^31, so the arithmetic is exact in
        a 63-bit Int. *)
(* note: Poly/ML compiles this to native code and the call is cheap: 0.631 s
        for 331 160 281 calls is 1.9 ns per call. That is the figure that
        separates this row from the interpreted ones, where the same cell
        takes minutes. *)
fun fib n = if n < 2 then n else fib (n - 1) + fib (n - 2)

fun main () =
  let
    val t0 = Time.now ()
    val result = fib 40
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
