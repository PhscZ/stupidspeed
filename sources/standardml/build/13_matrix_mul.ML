(* build driver for 13_matrix_mul.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "13_matrix_mul.sml";
val () = PolyML.export ("13_matrix_mul", main);
