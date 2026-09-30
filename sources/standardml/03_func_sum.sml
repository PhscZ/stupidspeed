(* task 03 func_sum — expected output: 100000000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/03_func_sum.ML
            (writes 03_func_sum.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 03_func_sum.exe 03_func_sum.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./03_func_sum.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: add_one lives in its own file, 03_func_sum_add_one.sml, loaded with
        `use`, so the call crosses a translation unit — the spec's "put the
        function in its own file" option. *)
(* note: Poly/ML has NO per-function no-inline annotation. PolyML.Compiler
        exposes only maxInlineSize, lowlevelOptimise and inlineFunctors, and
        none of them is an attribute you can put on a function. *)
(* note: a separate file is NOT enough on its own. With
        PolyML.Compiler.assemblyCode := true, the loop compiled to the same
        `AddRR64 rax <= 2` as a hand-written `v + 1`, and 100 000 000
        "calls" took 0.0628 s — the call had been deleted, which is exactly
        what the task warns about. *)
(* note: `PolyML.Compiler.maxInlineSize := 0` therefore has to be set BEFORE
        the helper is loaded. It is a global that takes effect at
        compilation time, so setting it after the `use` changes nothing
        (measured: 0.0338-0.0630 s, still inlined). Set first, the assembly
        dump contains `CallAddress CODE "add_one(1)"` and the time is 0.0711
        s, so the call really happens a hundred million times. *)
(* note: measured: 0.218 s as a linked executable, 0.71 ns per call on its
        own. *)
val () = PolyML.Compiler.maxInlineSize := 0;
use "03_func_sum_add_one.sml";

fun main () =
  let
    fun loop (i, v) = if i >= 100000000 then v else loop (i + 1, add_one v)
  in
    print (Int.toString (loop (0, 0)) ^ "\n")
  end
