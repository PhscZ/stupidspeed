(* build driver for 15_file_write.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "15_file_write.sml";
val () = PolyML.export ("15_file_write", main);
