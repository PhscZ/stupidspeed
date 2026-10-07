(* build driver for 09_fib_recursive.sml — this is the compile half of the two-command build.
   It loads the task source and exports the whole heap image to an object file.
   `polyc`, which the MSI does not ship, does exactly this on Windows. *)
use "09_fib_recursive.sml";
val () = PolyML.export ("09_fib_recursive", main);
