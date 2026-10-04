(* task 15 file_write — expected output: 52428800 *)
(* build: ocamlopt -unsafe -o prog.exe _15_file_write.ml *)
(* run: prog.exe *)
(* note: the row is built from the MSYS2 UCRT64 package mingw-w64-ucrt-x86_64-ocaml
         (OCaml 5.4.1). Two environment details are required and are not obvious:
         OCAMLLIB must be set to the *Windows* form of the stdlib directory
         (C:\...\ucrt64\lib\ocaml), because ocamlopt is a native Win32 binary and the
         MSYS2-style /ucrt64/... path baked into its config resolves to nothing -- without
         it every compile fails with 'Unbound module Stdlib'. And the separate
         mingw-w64-ucrt-x86_64-flexdll package has to be installed, or the link step stops
         with "'flexlink' is not recognized". *)
(* note: -unsafe turns off array and string bounds checks, which is the usual speed knob
         for OCaml. -O3 is accepted but is a no-op here: this switch reports
         flambda: false, and -O3 only does anything under Flambda. *)
(* note: filenames carry the row's _ prefix. OCaml derives a module name from the file
         name and a module name has to be a valid identifier, so 01_branches.ml draws
         'Warning 24: bad source file name'; _01_branches.ml compiles clean. *)
(* note: the 1 MiB buffer is written 50 times, then flushed and closed. OCaml has no standard
         fsync, so the deviation is flush plus close -- the same one the Tcl, D, Julia, Nim, Dart,
         Pascal, COBOL and Dolphin rows note. *)
(* timing: Unix.gettimeofday is the clock this build of the Unix module exposes (there is
   no clock_gettime binding here, so the monotonic clock is not reachable from OCaml);
   TIME_MS goes to stderr through Printf.eprintf and stdout is unchanged. *)
let ss_t0 = ref 0.0
let ss_now () = Unix.gettimeofday () *. 1000.0
let ss_report () = Printf.eprintf "TIME_MS=%.3f\n" (ss_now () -. !ss_t0)

let () =
  ss_t0 := ss_now ();
  let chunk = 1048576 in
  let buf = Bytes.create chunk in
  for i = 0 to chunk - 1 do
    Bytes.unsafe_set buf i (Char.chr (i mod 256))
  done;
  let oc = open_out_bin "out.bin" in
  for _ = 1 to 50 do
    output oc buf 0 chunk
  done;
  flush oc;
  close_out oc;
  ss_report ();
  Printf.printf "%d\n" (50 * chunk)
