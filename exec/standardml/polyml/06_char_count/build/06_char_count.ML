(* build driver for 06_char_count.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "06_char_count.sml";
val () = PolyML.export ("06_char_count", main);
