(* build driver for 14_file_read.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "14_file_read.sml";
val () = PolyML.export ("14_file_read", main);
