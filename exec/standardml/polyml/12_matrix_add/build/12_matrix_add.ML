(* build driver for 12_matrix_add.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "12_matrix_add.sml";
val () = PolyML.export ("12_matrix_add", main);
