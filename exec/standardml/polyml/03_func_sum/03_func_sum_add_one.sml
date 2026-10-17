(* task 03 func_sum — the helper, in its own file so the call crosses a translation unit.
   This is the spec's "put the function in its own file" option. It is loaded by
   03_func_sum.sml with `use`, AFTER that file has set PolyML.Compiler.maxInlineSize := 0;
   see the notes there for the assembly evidence that a separate file alone does not stop
   Poly/ML from inlining the call away. *)
fun add_one (n : int) = n + 1
