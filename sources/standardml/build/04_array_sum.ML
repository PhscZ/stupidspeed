(* build driver for 04_array_sum.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "04_array_sum.sml";
val () = PolyML.export ("04_array_sum", main);
