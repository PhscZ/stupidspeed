(* build driver for 07_string_append.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "07_string_append.sml";
val () = PolyML.export ("07_string_append", main);
