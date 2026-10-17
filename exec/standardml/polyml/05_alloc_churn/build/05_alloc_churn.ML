(* build driver for 05_alloc_churn.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "05_alloc_churn.sml";
val () = PolyML.export ("05_alloc_churn", main);
