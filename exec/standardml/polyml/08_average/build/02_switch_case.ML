(* build driver for 02_switch_case.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "02_switch_case.sml";
val () = PolyML.export ("02_switch_case", main);
