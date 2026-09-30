(* task 07 string_append — expected output: 1000000 *)
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
        whole accumulator, and a million appends move about 5x10^11 bytes. *)
(* note: it is quadratic, and measured as such: 100k 0.819 s, 200k 3.437 s
        (4.20x), 400k 15.548 s (4.52x), 800k 74.874 s (4.82x), 1000000 95.44
        s. Doubling the count multiplies the time by 4.2-4.8, which is the
        intended result — the same quadratic cell the JVM, Racket and Octave
        rows have, and the reason README leaves this count at a million. *)
(* note: a String.concat or byte-buffer route would be a different
        algorithm, so it is not used. *)
(* note: `String.size` is what is printed, so the loop cannot be deleted. *)
(* note: this is the slowest cell in the row by two orders of magnitude:
        95-96 s against sub-second for everything else. *)
fun main () =
  let
    fun app (k, s) = if k = 0 then s else app (k - 1, s ^ "x")
    val text = app (1000000, "")
  in
    print (Int.toString (String.size text) ^ "\n")
  end
