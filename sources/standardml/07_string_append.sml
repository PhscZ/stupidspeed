(* task 07 string_append — expected output: 250000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/07_string_append.ML
            (writes 07_string_append.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 07_string_append.exe 07_string_append.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./07_string_append.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: this is the plain `s ^ "x"` recursion the spec asks for, on the
        plain string type. *)
(* note: SML strings are immutable and there is no growable string in the
        Basis, so `^` allocates a fresh string of `size a + size b` and
        copies both operands into it. Every append therefore copies the
        whole accumulator, and 250000 appends move about 3.1x10^10 bytes. *)
(* note: it is quadratic — the same quadratic cell the JVM, Racket and Octave
        rows have, and the reason README sets this count at 250000. *)
(* note: a String.concat or byte-buffer route would be a different
        algorithm, so it is not used. *)
(* note: `String.size` is what is printed, so the loop cannot be deleted. *)
(* note: this is the slowest cell in the row. *)
fun main () =
  let
    val __t0 = Time.now ()
    fun app (k, s) = if k = 0 then s else app (k - 1, s ^ "x")
    val text = app (250000, "")
    val result = String.size text
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), __t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
