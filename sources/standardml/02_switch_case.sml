(* task 02 switch_case — expected output: 7500000075000000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/02_switch_case.ML
            (writes 02_switch_case.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 02_switch_case.exe 02_switch_case.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./02_switch_case.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: SML has no `switch` statement; `case` on an integer is the
        language's own four-way dispatch, and Poly/ML compiles it to a
        compare chain, the same shape the C row gets. *)
(* note: the accumulator is an Int, which is 63-bit here, and the total
        7500000075000000 is below 2^62, so every partial sum is exact. Task
        11 prints this same number from four quarters, so the two cells are
        directly comparable. *)
(* note: measured: 0.296 s, 3.0 ns per iteration. *)
fun main () =
  let
    val acc = ref 0
    fun loop i =
      if i >= 100000000 then ()
      else
        (acc := !acc + (case i mod 4 of 0 => 1 | 1 => i | 2 => 2 * i | _ => 3 * i);
         loop (i + 1))
  in
    loop 0;
    print (Int.toString (!acc) ^ "\n")
  end
