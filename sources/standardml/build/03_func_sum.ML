(* build driver for 03_func_sum.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "03_func_sum.sml";
val () = PolyML.export ("03_func_sum", main);
