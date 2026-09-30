(* task 01 branches — expected output: 33333334 13333333 7619048 45714285 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/01_branches.ML
            (writes 01_branches.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 01_branches.exe 01_branches.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./01_branches.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: the four counters are `ref`s. Poly/ML's native compiler cannot keep
        them in registers across the recursive loop, and a `ref` is a
        one-word mutable cell, so this is the plain four-counter loop the
        spec asks for. *)
(* note: `if ... then ... else if ...` is the if/else chain, and `mod` on
        these non-negative values is the floor modulus — the same operation
        C's `%` performs. *)
(* note: Int is a fixed 63-bit tagged integer here (Int.precision = SOME 63)
        and the largest counter is 45714285, so there is no question of
        overflow. *)
(* note: measured: 0.581 s, 5.8 ns per iteration. *)
fun main () =
  let
    val a = ref 0
    val b = ref 0
    val c = ref 0
    val d = ref 0
    fun loop i =
      if i >= 100000000 then ()
      else
        (if i mod 3 = 0 then a := !a + 1
         else if i mod 5 = 0 then b := !b + 1
         else if i mod 7 = 0 then c := !c + 1
         else d := !d + 1;
         loop (i + 1))
  in
    loop 0;
    print (Int.toString (!a) ^ " " ^ Int.toString (!b) ^ " " ^
           Int.toString (!c) ^ " " ^ Int.toString (!d) ^ "\n")
  end
