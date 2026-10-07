(* build driver for 10_pi.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "10_pi.sml";
val () = PolyML.export ("10_pi", main);
